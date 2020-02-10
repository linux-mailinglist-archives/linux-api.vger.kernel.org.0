Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1E1581A1
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 18:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBJRqs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 12:46:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42645 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgBJRqr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 12:46:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so4833164lfl.9
        for <linux-api@vger.kernel.org>; Mon, 10 Feb 2020 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMABvWd/7c4TphsJ+M/Bzt18EBtYsvxejNNk0qYwcjM=;
        b=AJWGb7viPUuSlXbBtks15QbiGc0V+5N1kFBw6HmGv/BocUHZwmHNnivHvSwIiPeEQm
         1fliH10RGyoPY6yV4O5rwY5izrulFkNof0M2GsGbSrfCirug6Mx7f0jNvrzCMioGftQD
         acWtx/PsAUjj64YLYfwg5kSuWK5If6M0QpBoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMABvWd/7c4TphsJ+M/Bzt18EBtYsvxejNNk0qYwcjM=;
        b=sriJIHrfkkq1GQpIvwaAzFecrXrIgb5Sv6wxBOvPKs36RHQGEd3yARDQmm8QyjDd8e
         XsD4h7tcW5P6dgIVqTDNPIsL76CiyWvwqfU5ybziRn7uT1+sxS76wEvEMAdbstSF1I+N
         X8uRZL398xgGQ2WwsBUa1sTmxiLQ5gpwIT93t0kZ5WK46xIVrj4vzFjlPZAg6OKNWUlT
         spO3UuerUwVZQKeiUCgyzE82ky3IDHAUoxTnqZorsSzKCjD/Yoo5G+tdIqDxyrQ1Cx77
         hAbcfQpTBZUIahXHNy6uQsZN+Lx3QSyKI5Xf6kskF7dAcEoGg634oU6PiLpsU2gfAyYh
         mMLA==
X-Gm-Message-State: APjAAAUhJIFxrupKTwJdVoN96G1gIO89pd+so8L/6NgcdcI0uzFft11e
        kDbjsdeWgt1Y0CsKBumhvAWkjOEAdMk=
X-Google-Smtp-Source: APXvYqxUhSJbYzvSCWYXA6rAzQlu8h3mJIsSg7ZolUYPh39lYZ4CioGxclM98A1bxiwKNm46T7Jhpg==
X-Received: by 2002:ac2:44d5:: with SMTP id d21mr1321240lfm.188.1581356804539;
        Mon, 10 Feb 2020 09:46:44 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id w3sm637267ljo.66.2020.02.10.09.46.42
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 09:46:43 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id h23so8202484ljc.8
        for <linux-api@vger.kernel.org>; Mon, 10 Feb 2020 09:46:42 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr1591348lja.204.1581356802297;
 Mon, 10 Feb 2020 09:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com> <20200210150519.538333-8-gladkov.alexey@gmail.com>
In-Reply-To: <20200210150519.538333-8-gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Feb 2020 09:46:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh05FniF0xJYqcFrmGeCvOJUqR0UL4jTC-_LvpsfNCkNw@mail.gmail.com>
Message-ID: <CAHk-=wh05FniF0xJYqcFrmGeCvOJUqR0UL4jTC-_LvpsfNCkNw@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
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
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This allows to flush dcache entries of a task on multiple procfs mounts
> per pid namespace.
>
> The RCU lock is used because the number of reads at the task exit time
> is much larger than the number of procfs mounts.

Ok, this looks better to me than the previous version.

But that may be the "pee-in-the-snow" effect, and I _really_ want
others to take a good look at the whole series.

The right people seem to be cc'd, but this is pretty core, and /proc
has a tendency to cause interesting issues because of how it's
involved in a lot of areas indirectly.

Al, Oleg, Andy, Eric?

             Linus
