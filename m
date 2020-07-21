Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FDD228673
	for <lists+linux-api@lfdr.de>; Tue, 21 Jul 2020 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgGUQtj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Jul 2020 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgGUQth (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Jul 2020 12:49:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80FC061794
        for <linux-api@vger.kernel.org>; Tue, 21 Jul 2020 09:49:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r19so24736608ljn.12
        for <linux-api@vger.kernel.org>; Tue, 21 Jul 2020 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfw0I9KLEinugvOkAIz5pYOKJ30/9U2i4w2l/E0VlLI=;
        b=PjZtpMWcBcYWc/PE2aBDgylpCarGxoRxa+Aq0zab6N7GaIbKRzPu2GNf3RxtSC05dA
         0K7/GHfK0uf/8tRqEMTILPd7F3g3dNdNNYY6ahsv+8BW0iD5iZnwvyqTPsbIeqjdBP3p
         khN1GHy7kDI63rJCnCaLHtNH6mG1r6HGYxAjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfw0I9KLEinugvOkAIz5pYOKJ30/9U2i4w2l/E0VlLI=;
        b=EeR7iT6jGJxj+7QWgbWLJxCR4PlnKZ1xqKN8LR+KG2nj7prBxmLMjQXL6wk2Cmozdu
         bzRYgKAOrS4h+TnEGNQIyCq+8dcPUKb88ChUUY5bZa3d5gvcR0x6vKn8D0oXOqqqv61z
         qWmUQ3EubkR2W27I0DNYRui3aTdatAgQUPpXEcVNFWE3bkNVYNhOxaONyCNQrV29eZvP
         1RfMlqKcxvd1dHJQQg0KPw/kv/cZEkk8d/dDe6C9PBfBeTfI7qFB2jlj13LkDJKK3w6l
         VFRUMUPS0+9eNiFvVJwjNhZxDbvSN67b9Ya7IaIx8dvv4DEX4pT1CtVlj3rZx/aM0zgb
         Xmew==
X-Gm-Message-State: AOAM530BcPycOV1N6CO1uxy3jHSsqfOTGuCLbIek/PWYdlaZorMXnmgq
        DMM5erCFDROMIRiqTXZw0X7p9sHxK+g=
X-Google-Smtp-Source: ABdhPJxx5Bi08DnTmMQhe0zG3HO5Ivj5DQvzIEJv1YqjETt0kI3qCSY9ISCELocP5Yr7gN+o4lmlAA==
X-Received: by 2002:a2e:8786:: with SMTP id n6mr13871032lji.428.1595350175286;
        Tue, 21 Jul 2020 09:49:35 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r15sm4701979ljd.130.2020.07.21.09.49.33
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 09:49:34 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id e8so24849610ljb.0
        for <linux-api@vger.kernel.org>; Tue, 21 Jul 2020 09:49:33 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr13904367ljc.285.1595350173585;
 Tue, 21 Jul 2020 09:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200721162818.197315-1-hch@lst.de> <20200721162818.197315-6-hch@lst.de>
In-Reply-To: <20200721162818.197315-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 09:49:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0GQqAq6VSY=O2iWnPuuS54TkyRBH5B9Ca0Kg5A9d2aA@mail.gmail.com>
Message-ID: <CAHk-=wi0GQqAq6VSY=O2iWnPuuS54TkyRBH5B9Ca0Kg5A9d2aA@mail.gmail.com>
Subject: Re: [PATCH 05/24] devtmpfs: open code ksys_chdir and ksys_chroot
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 21, 2020 at 9:28 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +
> +       /* traverse into overmounted root and then chroot to it */
> +       if (!kern_path("/..", LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path) &&
> +           !inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR) &&
> +           ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
> +           !security_path_chroot(&path)) {
> +               set_fs_pwd(current->fs, &path);
> +               set_fs_root(current->fs, &path);
> +       }
> +       path_put(&path);

This looks wrong.

You're doing "path_put()" even if kern_path() didn't succeed.

As far as I can tell, that will either put some uninitialized garbage
and cause an oops, or put something that has already been released by
the failure path.

Maybe that doesn't happen in practice in this case, but it's still
very very wrong.

Plus you shouldn't have those kinds of insanely complex if-statements
in the first place. That was what caused the bug - trying to be
clever, instead of writing clear code.

I'm not liking how I'm finding fundamental mistakes in patches that
_should_ be trivial conversions with no semantic changes.

               Linus
