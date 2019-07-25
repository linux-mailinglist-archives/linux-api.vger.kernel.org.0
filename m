Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB307433C
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 04:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfGYCX5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 22:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388629AbfGYCX5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 24 Jul 2019 22:23:57 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2832190F;
        Thu, 25 Jul 2019 02:23:56 +0000 (UTC)
Date:   Wed, 24 Jul 2019 22:23:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V36 27/29] tracefs: Restrict tracefs when the kernel is
 locked down
Message-ID: <20190724222354.7cbd6c6e@oasis.local.home>
In-Reply-To: <20190718194415.108476-28-matthewgarrett@google.com>
References: <20190718194415.108476-1-matthewgarrett@google.com>
        <20190718194415.108476-28-matthewgarrett@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 18 Jul 2019 12:44:13 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

> @@ -387,6 +412,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  				   struct dentry *parent, void *data,
>  				   const struct file_operations *fops)
>  {
> +	struct file_operations *proxy_fops;
>  	struct dentry *dentry;
>  	struct inode *inode;
>  
> @@ -402,8 +428,18 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  	if (unlikely(!inode))
>  		return failed_creating(dentry);
>  
> +	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
> +	if (!proxy_fops)

I believe we need "iput(inode);" here. Or move the allocation before
the inode allocation and free it on inode failure.

-- Steve

> +		return failed_creating(dentry);
> +
> +	if (!fops)
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
