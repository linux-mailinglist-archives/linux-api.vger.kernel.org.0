Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1483B14973F
	for <lists+linux-api@lfdr.de>; Sat, 25 Jan 2020 19:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAYSpt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 25 Jan 2020 13:45:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43013 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAYSps (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 25 Jan 2020 13:45:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so6251067ljm.10
        for <linux-api@vger.kernel.org>; Sat, 25 Jan 2020 10:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agKBgndk3wOWKqvCTJf0yLyX2bJKGsFMAU50Ri7/n9U=;
        b=ebrkpC8lWGHzj/TTwQVlGmpfBj+LMhP3xc48s3IkdXLpfPBkmBQH8glAibN3NZzhJ7
         eaX+oPyIl6RK4Fcu/p33lei0jipvUcU+PHgqX1Ir4aJDuHlpLIX4SbceygCECD/xiFMl
         QwEsuOsJJnKRw8LKLW82q3yqXp++TF+4Q343k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agKBgndk3wOWKqvCTJf0yLyX2bJKGsFMAU50Ri7/n9U=;
        b=BINWpEyUoMCIGUulleb8lexoGC/b1mvjyFFiYB45IO8MdY4WnwhIJac25PHaPIYt9E
         6+QZC6A5h/OaxboPm3idpBumaC5YOER6jUbR5Hh0OXzE/EhfbGwrbis39+LFEUkuJKjn
         FEnXNWJAKImjA0y4qRCtwxymXYRVpB+cv0VZuWvN1unu8zn23tbp1GPPcxv1y7f3JCUI
         V9Q3yLB3XVGAPjHvVqOKfHtLt2JwpjeByau/8uD1ZFDbbHrNsveVAEXFS/d9B20WV4PS
         +KFqbEtieR0xp2JJVxYrfArHNOHl7VkLrs05OzGd0ZcLE4+Yh1SCvpjUuPu88rr5DqMU
         U6ZQ==
X-Gm-Message-State: APjAAAVZPknqbffHh/fI50lomBdVrnd37sWFVPTdj9nipGH7tnxBfpA9
        8rjv225wRLGEOCVltGEYBShi7RASyew=
X-Google-Smtp-Source: APXvYqx2zHSKJhkGn/twQxLVievrWqUrQKDTSmYAzp5QDeuc9UEurc4YUW7PCRNh+y7M80vcxkvDkg==
X-Received: by 2002:a2e:8316:: with SMTP id a22mr5165014ljh.141.1579977945855;
        Sat, 25 Jan 2020 10:45:45 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m13sm5149181lfo.40.2020.01.25.10.45.42
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 10:45:45 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id a13so6250945ljm.10
        for <linux-api@vger.kernel.org>; Sat, 25 Jan 2020 10:45:42 -0800 (PST)
X-Received: by 2002:a05:651c:ce:: with SMTP id 14mr2080983ljr.241.1579977941361;
 Sat, 25 Jan 2020 10:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20200125130541.450409-1-gladkov.alexey@gmail.com> <20200125130541.450409-8-gladkov.alexey@gmail.com>
In-Reply-To: <20200125130541.450409-8-gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jan 2020 10:45:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGNSQCA8TYa1Akp0_GRpe=ELKDPkDX5nzM5R=oDy1U+Q@mail.gmail.com>
Message-ID: <CAHk-=wiGNSQCA8TYa1Akp0_GRpe=ELKDPkDX5nzM5R=oDy1U+Q@mail.gmail.com>
Subject: Re: [PATCH v7 07/11] proc: flush task dcache entries from all procfs instances
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jan 25, 2020 at 5:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This allows to flush dcache entries of a task on multiple procfs mounts
> per pid namespace.

From a quick read-through, this is the only one I really react negatively to.

The locking looks odd. It only seems to protect the new proc_mounts
list, but then it's a whole big rwsem, and it's taken over all of
proc_flush_task_mnt(), and the locking is exported to all over as a
result of that - including the dummy functions for "there is no proc"
case.

And proc_flush_task_mnt() itself should need no locking over any of
it, so it's all just for the silly looping over the list.

So

 (a) this looks fishy and feels wrong - I get a very strong feeling
that the locking is wrong to begin with, and could/should have been
done differently

 (b) all the locking should have been internal to /proc, and those
wrappers shouldn't exist in a common header file (and certainly not
for the non-proc case).

Yes, (a) is just a feeling, and I don't have any great suggestions.
Maybe make it an RCU list and use a spinlock for updating it?

But (b) is pretty much a non-starter in this form. Those wrappers
shouldn't be in a globally exported core header file. No way.

               Linus
