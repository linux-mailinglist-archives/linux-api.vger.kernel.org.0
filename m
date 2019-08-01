Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC37D4D7
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 07:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfHAFVu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 01:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfHAFVu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Aug 2019 01:21:50 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE6FD217D6
        for <linux-api@vger.kernel.org>; Thu,  1 Aug 2019 05:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564636909;
        bh=u+NSo7Xr4J1UtkMZ3fciXvWnaLTy5NZ6RahWBeS9LmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mvuWiNcjnkdgux7/V9zdw/CbL7WYYUan9Q77SVHBhH3noYYsZuXb0NKSMCWcEZKGi
         VruQmywIYp6mZ1+kCE7PELTMGYBZ4VfAu95uMEPLkZB/0w41MHbDGCd6urDAcbN15W
         bj9C8vxiiH+mOLwHLSa7Cd9+cfUX5EiIFFz2+MOQ=
Received: by mail-wr1-f43.google.com with SMTP id g17so72078258wrr.5
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 22:21:48 -0700 (PDT)
X-Gm-Message-State: APjAAAXN0Lc7WLnl1bvxrzVc5RM+qStzIuZXK0/+pbRfjgw0upVz6ttn
        Yqk2iTLixbX7PTnxwtrdlV7JbhQiz0EMlrHfERlhEQ==
X-Google-Smtp-Source: APXvYqxNJs/3/OM7xqG0+zDXb7EBWla6AbxRiGjvW6rkDb7FQKOQktYbohBvB/SLjkC7L+f9sGNcWYMeV/oHVVfUhzY=
X-Received: by 2002:adf:cf02:: with SMTP id o2mr118390659wrj.352.1564636905321;
 Wed, 31 Jul 2019 22:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-29-dima@arista.com>
In-Reply-To: <20190729215758.28405-29-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Jul 2019 22:21:33 -0700
X-Gmail-Original-Message-ID: <CALCETrXL6pzDoHfn9Niw_CxNX-_W3=yotDYuqK+kxPhOLofmNA@mail.gmail.com>
Message-ID: <CALCETrXL6pzDoHfn9Niw_CxNX-_W3=yotDYuqK+kxPhOLofmNA@mail.gmail.com>
Subject: Re: [PATCHv5 28/37] x86/vdso: Enable static branches for the timens vdso
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
>
> From: Andrei Vagin <avagin@gmail.com>
>
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
>
> Addressing those problems, there are two versions of VDSO's .so:
> for host tasks (without any penalty) and for processes inside of time
> namespace with clk_to_ns() that subtracts offsets from host's time.
>
> The timens code in vdso looks like this:
>
> if (timens_static_branch_unlikely()) {
>        clk_to_ns(clk, ts);
> }

I'm confused.  Now we effectively have *three* versions: the vDSO
without timens, and vDSO with timens but with it switched off, and the
vDSO with timens on.  This seems like too much.

What you need is, IMO, a static-branch-ish thing that is per mm.  This
has a fundamental problem that the vDSO can be modified using
FOLL_FORCE.  Perhaps any CoW of the vDSO should implicitly switch the
static branch on, which at least gives some degree of correctness even
if it's a bit surprising.

--Andy
