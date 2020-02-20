Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6D5166AAE
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 00:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgBTXCp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 18:02:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41028 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgBTXCn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 18:02:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so193214ljc.8
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 15:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oe6NGrWHTfgph3/inQD25AzfwK01P8Rirv0Se4y4rY=;
        b=eERYNg5pIV17feq4MuZzbw+6+6UOz8wPDMox8sHvl6LW5lyeCJiNPLjaaiAnC6tgNr
         k4eFpoUVZrOY+nWuuaeOf69/y2kMFcR2Xyd4iQCdWpyjSB4kE6JLltV8O5wbI2adfQ2q
         gkwegZ8+VoH9h8WqrHWMh85pZ16PVGc+EW3II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oe6NGrWHTfgph3/inQD25AzfwK01P8Rirv0Se4y4rY=;
        b=LnDKz7XzwOhFK4mOUjWfJkh7WBqkbrc5YxydYeTMzFQBeYo3NSkBnCSIf1SawWyV2w
         GZmueodv3v5FhX55LdO1SG3NHm4LdWLUBSSvBMSb4WxeI6L19GHion2+gmLeX9iEonxa
         BEIDDwTouWSVBxhO/BbtXXeE6kncnrD4fHWuY+9O8r0e5p/cChgV1vd3+GrSaXWhX/V9
         CGwjFaqE+Tz3TvaVucg2MCYuwgNjaczxIkxBdkAI8m0lHugFP5jpxuqSiGAnainfbG8g
         h4ao4QUTZAxH3fpC6Yw1/CLFtxc6BW1VwdoqrBU8zJZXozeKtF8kqjcJv7HhXT7hsq52
         9t+w==
X-Gm-Message-State: APjAAAWNgvqNHMo5dwmUnTAoqutI3mvMDPM/+l8v5BPRf22YFTk4dxGi
        zC6Od4mtnPG3CdlIhDqmc4wUHr3/3uI=
X-Google-Smtp-Source: APXvYqwCr2Ei2hxr+V3+dt7gOAQwfZIa6Aue1Jxi1gPv0YJ0CLNRCHaZWEov5RyesOoQEi4FRNHjQg==
X-Received: by 2002:a2e:6c06:: with SMTP id h6mr20271283ljc.246.1582239761149;
        Thu, 20 Feb 2020 15:02:41 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u9sm451107lji.49.2020.02.20.15.02.38
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 15:02:39 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id o15so203880ljg.6
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 15:02:38 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr19768759ljj.241.1582239758414;
 Thu, 20 Feb 2020 15:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 15:02:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whX7UmXgCKPPvjyQFqBiKw-Zsgj22_rH8epDPoWswAnLA@mail.gmail.com>
Message-ID: <CAHk-=whX7UmXgCKPPvjyQFqBiKw-Zsgj22_rH8epDPoWswAnLA@mail.gmail.com>
Subject: Re: [PATCH 0/7] proc: Dentry flushing without proc_mnt
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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

On Thu, Feb 20, 2020 at 12:48 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Linus, does this approach look like something you can stand?

A couple of worries, although one of them seem to have already been
resolved by Al.

I think the real gatekeeper should be Al in general.  But other than
the small comments I had, I think this might work just fine.

Al?

           Linus
