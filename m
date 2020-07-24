Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4721122CE87
	for <lists+linux-api@lfdr.de>; Fri, 24 Jul 2020 21:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGXTOn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jul 2020 15:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgGXTOk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jul 2020 15:14:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CEAC0619E5
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 12:14:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q4so11085045lji.2
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=td+POTQLbLYOoIxNCct7GsW10BBA9n/4Q5dVUic9E/Y=;
        b=BmStlzF53IfQFR9lW1QEwB6WtPaCTo8kB/5l2ZVbvkNCRtpkKknR7R7gwnINKZMYbo
         9roTE/qL7vaPo+Cyso47Tup2l6wwhF0x/6bkHDYtEfCuAEAXNXPJrsNboG8KVxzjNeDZ
         VsPfwtpzBsiG/8I7JDAyVredl46a3Ru8+ROxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=td+POTQLbLYOoIxNCct7GsW10BBA9n/4Q5dVUic9E/Y=;
        b=hBkzIwxKhkXxenhLY6PaM9zXFa5sMYKhdhO5dQvN5q5DmQQT5bK2bM2qyyYnLN5zQ7
         a26N6/E4WqPwtENi3ZD7WzCm0KHtQMcS7DWiYvvA6hHMlgGrjaDOQvX3HPJmUItX7q+Z
         rJ3LUviLpzEvnOxSaaPfjvVKRqC18RFq2LNyNjo5m70N1b2ueZ9wdTNljK34n61IrRL4
         Lg20mVBuWqxF5J05oTd1Wo3ncc3LoroBMvoGXZG9ZZ+iF0i6bWvbiYoZp0IuCEGUSi5Z
         H8Z4wTusMd3hChm6DcUvMNyq+G3d941PC7eRt5N5ROpJDrA6YIJ0M4nL2paccuobVyHn
         o24Q==
X-Gm-Message-State: AOAM533M4pJ06KARcmVVSxWxpPrBdjPkdW8v4lxnsM2m4ubK6BdvkKWO
        noVAZUEun70fG2N7w6gxYN0NAgwK/eI=
X-Google-Smtp-Source: ABdhPJwKJr1rQ2tERWcUVs26qGMfITugY5h4SVGNtPMp4YiPPkKSX185csIdfLDSy0pdHrAZjsNLBw==
X-Received: by 2002:a2e:b019:: with SMTP id y25mr5029966ljk.47.1595618077306;
        Fri, 24 Jul 2020 12:14:37 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r19sm438528ljn.40.2020.07.24.12.14.35
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 12:14:36 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id f5so11036824ljj.10
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 12:14:35 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr5228146ljj.312.1595618075547;
 Fri, 24 Jul 2020 12:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
 <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 12:14:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com>
Message-ID: <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com>
Subject: Re: [PATCH 3/4] watch_queue: Implement mount topology and attribute
 change notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@redhat.com>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This just can't be right.

On Fri, Jul 24, 2020 at 6:12 AM David Howells <dhowells@redhat.com> wrote:
>
> +
> +/**
> + * sys_watch_mount - Watch for mount topology/attribute changes
> + * @dfd: Base directory to pathwalk from or fd referring to mount.
> + * @filename: Path to mount to place the watch upon
> + * @at_flags: Pathwalk control flags
> + * @watch_fd: The watch queue to send notifications to.
> + * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
> + */
> +SYSCALL_DEFINE5(watch_mount, [...]
> +               int, watch_id)
...
> +       if (watch_id < -1 || watch_id > 0xff)
> +               return -EINVAL;
...
> +       ret = inode_permission(path.dentry->d_inode, MAY_EXEC);
> +       if (ret)
> +               goto err_path;
...
> +       if (watch_id >= 0) {
...
> +               watch = kzalloc(sizeof(*watch), GFP_KERNEL);
> +               if (!watch)
> +                       goto err_wlist;

So now you can basically allocate as much kernel memory as you want as
a regular user, as long as you have a mounted directory you can walk
(ie everybody).

Is there any limiting of watches anywhere? I don't see it.

I notice we already have this pattern elsewhere. I think we need to
fix this before we add more watch types.

Watch allocation shouldn't just be a kzalloc(). I think you should
have a "watch_allocate()" that does the initialization of id etc, but
also does some basic per-user watch resource tracking or something.

              Linus
