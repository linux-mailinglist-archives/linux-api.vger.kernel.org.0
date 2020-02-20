Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF1166AA3
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 00:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBTXAf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 18:00:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34211 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBTXAf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 18:00:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so223046ljc.1
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 15:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oW+dHyuXcdgcpFOp9rkCYNNzyvxL/1mmVUWMW1tVkn8=;
        b=HsJYplXHj9WIosfuyYDxgCIpizr4Q2QTncG0r8kQoBcqx1jdtsR9fFVeYAPGlhnI5Y
         7UWBHhKU9LT9oEd08VowjnmWRULPbdq+faWGzRjHU4lCzwffnnc4X3O8+YTbupxrOXam
         he3lTa6POmGxUb6ylyx451mYPhWfQQq6/MfdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oW+dHyuXcdgcpFOp9rkCYNNzyvxL/1mmVUWMW1tVkn8=;
        b=RtCgIJerdTJBAFns5fPw3keyrb56mFaAwkseI0r0NBHA9ZwgEyXUhue+ubqoHkIDvo
         mHR9LdDHUyjvp+XavLgiNr/mrlzSe2XRiM85Q95Zkrdvnp5ObbfRuiPwi6Lxso9Jocp1
         Ml1HGi3ASbdcNdhLpp+fp3TcTeilysQybCup8LEZUCGPR7L7ku/Fb/yqvWIn2J4d0tfT
         +NDLd62whb1UmJegmx/yc0FeDaJhy6g5MvegV27plYu8ROZMc2mNBIIlA9j0PRHLAuXu
         DKlnn3/zRIVjJvYxytcr4Va2rGwhVyWb5ZeQ4HkSsNE7sTvLdi7xh/E4bpJqqRsTvfPf
         vNwA==
X-Gm-Message-State: APjAAAUoCmq6dKexmEsUtYNAKLBMhit2LAkaLdC7zxLSaI9wmaYthB0v
        gm4bPtAoEipxCn3YEi+6Kt8k7ae+m5s=
X-Google-Smtp-Source: APXvYqzhglzq7D6pYQGZC6xzfPBEdCmbjR1BIHjkyfjOw8SMjmBmvFaU32Ls3ul4LZvmuuulZoKnEQ==
X-Received: by 2002:a2e:818e:: with SMTP id e14mr20042886ljg.2.1582239632727;
        Thu, 20 Feb 2020 15:00:32 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t24sm495738lfk.52.2020.02.20.15.00.30
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 15:00:30 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id n18so192447ljo.7
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 15:00:30 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20496205ljk.201.1582239629960;
 Thu, 20 Feb 2020 15:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87blpt9e6m.fsf_-_@x220.int.ebiederm.org> <20200220225420.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200220225420.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 15:00:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPwMTTaGtphubBXeiKitKigutddx9Fcp4Sf1sw4tpyeA@mail.gmail.com>
Message-ID: <CAHk-=whPwMTTaGtphubBXeiKitKigutddx9Fcp4Sf1sw4tpyeA@mail.gmail.com>
Subject: Re: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 20, 2020 at 2:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> s/no inode.*/it's a directory inode./

That actually makes my worry go away too. We don't allow aliases for
directory inodes, iirc.

So then it doesn't depend on some /proc implementation issue any more,
then it's fundamental that there's only one dentry.

            Linus
