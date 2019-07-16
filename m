Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB66B243
	for <lists+linux-api@lfdr.de>; Wed, 17 Jul 2019 01:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfGPXOn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jul 2019 19:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbfGPXOn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 16 Jul 2019 19:14:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A64B20880;
        Tue, 16 Jul 2019 23:14:41 +0000 (UTC)
Date:   Tue, 16 Jul 2019 19:14:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V35 27/29] tracefs: Restrict tracefs when the kernel is
 locked down
Message-ID: <20190716191439.59a1ac32@gandalf.local.home>
In-Reply-To: <20190715195946.223443-28-matthewgarrett@google.com>
References: <20190715195946.223443-1-matthewgarrett@google.com>
        <20190715195946.223443-28-matthewgarrett@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 15 Jul 2019 12:59:44 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

> Tracefs may release more information about the kernel than desirable, so
> restrict it when the kernel is locked down in confidentiality mode by
> preventing open().
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
> 

> @@ -389,6 +414,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  {
>  	struct dentry *dentry;
>  	struct inode *inode;
> +	struct file_operations *proxy_fops;

Small nit, but please add this as the first declaration, to keep the
"upside-down x-mas tree" look. I know some of the other functions in
this file don't follow that (which should be cleaned up some day), but
I'd like to avoid adding more that breaks the aesthetic of the code.

>  
>  	if (!(mode & S_IFMT))
>  		mode |= S_IFREG;
> @@ -402,8 +428,18 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  	if (unlikely(!inode))
>  		return failed_creating(dentry);
>  
> +	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
> +	if (!proxy_fops)
> +		return failed_creating(dentry);
> +
> +	if (fops)

I think you meant "if (!fops)".

-- Steve

> +		fops = &tracefs_file_operations;
> +
> +	dentry->d_fsdata = (void *)fops;
> +	memcpy(proxy_fops, fops, sizeof(*proxy_fops));
> +	proxy_fops->open = default_open_file;
>  	inode->i_mode = mode;
> -	inode->i_fop = fops ? fops : &tracefs_file_operations;
> +	inode->i_fop = proxy_fops;
>  	inode->i_private = data;
>  	d_instantiate(dentry, inode);
>  	fsnotify_create(dentry->d_parent->d_inode, dentry);
