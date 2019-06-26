Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F9C56A01
	for <lists+linux-api@lfdr.de>; Wed, 26 Jun 2019 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfFZNHw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Jun 2019 09:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfFZNHw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 26 Jun 2019 09:07:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422B421670;
        Wed, 26 Jun 2019 13:07:51 +0000 (UTC)
Date:   Wed, 26 Jun 2019 09:07:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V33 29/30] tracefs: Restrict tracefs when the kernel is
 locked down
Message-ID: <20190626090748.23eba868@gandalf.local.home>
In-Reply-To: <20190621011941.186255-30-matthewgarrett@google.com>
References: <20190621011941.186255-1-matthewgarrett@google.com>
        <20190621011941.186255-30-matthewgarrett@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 20 Jun 2019 18:19:40 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

> Tracefs may release more information about the kernel than desirable, so
> restrict it when the kernel is locked down in confidentiality mode by
> preventing open().
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  fs/tracefs/inode.c           | 41 +++++++++++++++++++++++++++++++++++-
>  include/linux/security.h     |  1 +
>  security/lockdown/lockdown.c |  1 +
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 7098c49f3693..f6c04fa8e415 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -24,6 +24,7 @@
>  #include <linux/parser.h>
>  #include <linux/magic.h>
>  #include <linux/slab.h>
> +#include <linux/security.h>
>  
>  #define TRACEFS_DEFAULT_MODE	0700
>  
> @@ -31,6 +32,21 @@ static struct vfsmount *tracefs_mount;
>  static int tracefs_mount_count;
>  static bool tracefs_registered;
>  
> +static int default_open_file(struct inode *inode, struct file *filp)
> +{
> +	struct dentry *dentry = filp->f_path.dentry;
> +	struct file_operations *real_fops;
> +
> +	if (!dentry)
> +		return -EINVAL;
> +
> +	if (security_is_locked_down(LOCKDOWN_TRACEFS))
> +		return -EPERM;
> +
> +	real_fops = dentry->d_fsdata;
> +	return real_fops->open(inode, filp);
> +}
> +
>  static ssize_t default_read_file(struct file *file, char __user *buf,
>  				 size_t count, loff_t *ppos)
>  {
> @@ -50,6 +66,13 @@ static const struct file_operations tracefs_file_operations = {
>  	.llseek =	noop_llseek,
>  };
>  
> +static const struct file_operations tracefs_proxy_file_operations = {
> +	.read =		default_read_file,
> +	.write =	default_write_file,
> +	.open =		default_open_file,
> +	.llseek =	noop_llseek,
> +};

This appears to be unused.

> +
>  static struct tracefs_dir_ops {
>  	int (*mkdir)(const char *name);
>  	int (*rmdir)(const char *name);
> @@ -225,6 +248,12 @@ static int tracefs_apply_options(struct super_block *sb)
>  	return 0;
>  }
>  
> +static void tracefs_destroy_inode(struct inode *inode)
> +{
> +	if (S_ISREG(inode->i_mode))
> +		kfree(inode->i_fop);
> +}
> +
>  static int tracefs_remount(struct super_block *sb, int *flags, char *data)
>  {
>  	int err;
> @@ -260,6 +289,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
>  
>  static const struct super_operations tracefs_super_operations = {
>  	.statfs		= simple_statfs,
> +	.destroy_inode  = tracefs_destroy_inode,
>  	.remount_fs	= tracefs_remount,
>  	.show_options	= tracefs_show_options,
>  };
> @@ -393,6 +423,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  {
>  	struct dentry *dentry;
>  	struct inode *inode;
> +	struct file_operations *proxy_fops;
>  
>  	if (!(mode & S_IFMT))
>  		mode |= S_IFREG;
> @@ -406,8 +437,16 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  	if (unlikely(!inode))
>  		return failed_creating(dentry);
>  
> +	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
> +	if (!proxy_fops)
> +		return failed_creating(dentry);
> +
> +	dentry->d_fsdata = fops ? (void *)fops :
> +		(void *)&tracefs_file_operations;
> +	memcpy(proxy_fops, dentry->d_fsdata, sizeof(struct file_operations));
> +	proxy_fops->open = default_open_file;
>  	inode->i_mode = mode;
> -	inode->i_fop = fops ? fops : &tracefs_file_operations;
> +	inode->i_fop = proxy_fops;


I think the above would look cleaner as:


	if (!fops)
		fops = &tracefs_file_operations;

	dentry->d_fsdata = (void *)fops;
	memcpy(proxy_fops, fops, sizeof(*proxy_fops);
	proxy_fops->open = default_open_file;

-- Steve

>  	inode->i_private = data;
>  	d_instantiate(dentry, inode);
>  	fsnotify_create(dentry->d_parent->d_inode, dentry);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 2563a9e3b415..040e7fc33397 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -100,6 +100,7 @@ enum lockdown_reason {
>  	LOCKDOWN_KPROBES,
>  	LOCKDOWN_BPF,
>  	LOCKDOWN_PERF,
> +	LOCKDOWN_TRACEFS,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index a6f7b0770e78..7dc601f06cd3 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -36,6 +36,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_KPROBES] = "use of kprobes",
>  	[LOCKDOWN_BPF] = "use of bpf",
>  	[LOCKDOWN_PERF] = "unsafe use of perf",
> +	[LOCKDOWN_TRACEFS] = "use of tracefs",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  

