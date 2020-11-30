Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4C2C919B
	for <lists+linux-api@lfdr.de>; Mon, 30 Nov 2020 23:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgK3Ww6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Nov 2020 17:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbgK3Ww5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Nov 2020 17:52:57 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E54BC0613D6
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 14:52:17 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id r24so25109165lfm.8
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 14:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQg0SNNWkwV7My6wc0FC7IpKl7QLq5MHv/j5j0aPpNA=;
        b=QuqQG9ADdDmV18jCrPnWfHcW15X5FNFPRcNOsTuadXp0R1ofszUYyn14cFgcYm1xt9
         Ohx+O/XrOQeBzi2yNeMof2W9YaRXAoKumW+LWK+qJSn1igYlensrTdITOtBIwPZWx8hE
         yhr6LcaDWCZeMzfGxo8TOF8bDqi5UbWdB4uhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQg0SNNWkwV7My6wc0FC7IpKl7QLq5MHv/j5j0aPpNA=;
        b=Ci4b25fvdh5ZBTenRgTuJOVcFfWHifCMUJP1BIgcpJmOg7NPLEH1xt9yv8U03J3WjX
         RMkb2BV/2EMQUcSKRkhPrQbCV6f6qavfqGAeNg+Y7iH87dw5Hzd1zJA+Aad0crPNPaDU
         q5M5+ozAmEVip/cgyRV+CbA02r+t3M+XYGeZ8CmCR7RAk0SjrUZLGxq2ue5Bif2z7mLG
         LJQVZDPRic57/RA5ZnQYlx5pVhj42GcMWyJ4CFduE7Y7ziONFBRLAhUFD1TBXsP1j+XB
         jWv3WhyNKDQVcwrZnARc0qF/2keOfkyzhjdIezmqq7ScufTy4c9uXqywCBCXU8NvZhBj
         CJqA==
X-Gm-Message-State: AOAM531RDZRakZIB2h8L2ASW8g7Ktv4AOJT7/xDN9osxNChFikBDuwcs
        g5FXcuKuW/1E7qFWQ//BV/DMvdYjs1CAlWk9YWJMiw==
X-Google-Smtp-Source: ABdhPJz6lQl/wsVF1Ne7U27EUw+OIPqS46oDCHQlHg6Xbv5haiwWr87dAhx/ApTPrUOy9koOzRi6b9gPinDiWazEth4=
X-Received: by 2002:a19:8684:: with SMTP id i126mr841376lfd.561.1606776735655;
 Mon, 30 Nov 2020 14:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com> <20201128213527.2669807-34-christian.brauner@ubuntu.com>
In-Reply-To: <20201128213527.2669807-34-christian.brauner@ubuntu.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Mon, 30 Nov 2020 17:52:04 -0500
Message-ID: <CAHap4zvDuSpZzeyZPc61mQURu_0oGKjkiROohYXkAFYyD85Vvw@mail.gmail.com>
Subject: Re: [PATCH v3 33/38] ext4: support idmapped mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        containers@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, smbarber@chromium.org,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, selinux@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        fstests@vger.kernel.org, linux-security-module@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index 619dd35ddd48..5918c05cfe5b 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -118,3 +118,12 @@ config EXT4_KUNIT_TESTS
>           to the KUnit documentation in Documentation/dev-tools/kunit/.
>
>           If unsure, say N.
> +
> +config EXT4_IDMAP_MOUNTS
> +       bool "Support vfs idmapped mounts in ext4"
> +       depends on EXT4_FS
> +       default n
> +       help
> +         The vfs allows to expose a filesystem at different mountpoints with
> +         differnet idmappings. Allow ext4 to be exposed through idmapped

s/differnet/different/g
