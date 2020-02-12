Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4815B016
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 19:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLSp2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 13:45:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36692 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLSp2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 13:45:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so3544922ljg.3
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8S2w7jKfhj8nqr2BEN6cbFr7nckGF3MBI5pTAOk2Bgk=;
        b=E/vN3AE3iyzGDOzjrhIyYOh5wyK5H3COrkDAy4Yb/0fuIwlyf50yEW7S/x5cDf9tHW
         zWbCuDLoLaAGtRSBjikTyE8yY06byotE/cGEhEbxOklsxfNCa9G0PsCjeYAs62WP1DSa
         M2BG1IabKnVo1IvqnOENDDauUUlMg+SJyMK4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8S2w7jKfhj8nqr2BEN6cbFr7nckGF3MBI5pTAOk2Bgk=;
        b=Q/rMp23Cvdf1pauZ+Ys1qe2shhyhfCetmgd0MVtgCkTB9xjIay0eB1pT5G30NQO9kH
         6JK6E46iX/ZtMX8ZM1uknBFoLA1/Wc7Xu3wq35mO0ZMDrlAGUqc6pVJiiRKr2TKHliDd
         6SVfaDKOBgYUi4bI978fv3eMa2TegYXwN5tQdixMatPbVTK1kr1fbctbalpAEQWyq5eR
         pGXDG/K9sSJZbz3OuRRkFZvQhvrtdM6I1D7fTtNqKjOXXAfSzaE0YGSe+Cr/7ULdQpY4
         CtxW1eFK/zpXrivV0Y1QIUxN/blH8nTKhtIFpT3ADfu68LQpcnFHmxEZH1azsfJxKdkf
         Bb2Q==
X-Gm-Message-State: APjAAAVcZXTWssONk8JOEJFD7SPvcVpCwasJgHu7RoebESydB2jygutT
        ClREoHMcucFl4OD7jDGu3msPUXPfFsE=
X-Google-Smtp-Source: APXvYqzXAEZzM3cmyLH4wd5zI93L6sQpGB4/Mcw/6CByRE6CTRRFXWKqyk3nLuKJe7cwT9b7jtZWYw==
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr8858141ljm.68.1581533125360;
        Wed, 12 Feb 2020 10:45:25 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t27sm9944ljd.26.2020.02.12.10.45.23
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 10:45:23 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id n18so3521841ljo.7
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 10:45:23 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr8440902ljj.241.1581533122702;
 Wed, 12 Feb 2020 10:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6> <87tv3vkg1a.fsf@x220.int.ebiederm.org>
In-Reply-To: <87tv3vkg1a.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 10:45:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
Message-ID: <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     "Eric W. Biederman" <ebiederm@xmission.com>
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

On Wed, Feb 12, 2020 at 7:01 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Fundamentally proc_flush_task is an optimization.  Just getting rid of
> dentries earlier.  At least at one point it was an important
> optimization because the old process dentries would just sit around
> doing nothing for anyone.

I'm pretty sure it's still important. It's very easy to generate a
_ton_ of dentries with /proc.

> I wonder if instead of invalidating specific dentries we could instead
> fire wake up a shrinker and point it at one or more instances of proc.

It shouldn't be the dentries themselves that are a freeing problem.
They're being RCU-free'd anyway because of lookup. It's the
proc_mounts list that is the problem, isn't it?

So it's just fs_info that needs to be rcu-delayed because it contains
that list. Or is there something else?

               Linus
