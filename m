Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D01FBC47
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 19:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgFPRCB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 13:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730107AbgFPRB6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 16 Jun 2020 13:01:58 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F408F21534
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592326918;
        bh=x7sF8JlhivKiZx8ZWX3Ydrzfg2JpqrUkultDOGGYPI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S53Pz11cN6hVnM6NPkjIYCgBQ6wh4ZQFysmgAoUqduDe8+6dA7fk3p/mtl2Mcoyo8
         JjVG24/2JXAuNvYMY0c4Sh2D54tYZh11rmoGY97VuW28l2N6NVUbZxAjktNmFcFniE
         tCR2L6JLTmyEERPcH2c8pT6tlmZzwWu8CKDSNt/g=
Received: by mail-ej1-f54.google.com with SMTP id dr13so22293799ejc.3
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 10:01:57 -0700 (PDT)
X-Gm-Message-State: AOAM533CYNciywqIggsx5gwlErogrpn4UdB9yzAkiro4LGrTllniwRDv
        77cuTY+Z9bZ2eU5ERpqKJGBvQhr1pHfT55Cr3jc5AQ==
X-Google-Smtp-Source: ABdhPJwrvBoMEGMkP0gYqhwknR6xR8IcaGNlyuVcjfKiRw+lPcX8g8lGzKUCzXmybftwQB7Yn6fFe8MGNmpFIBzxBWI=
X-Received: by 2002:a5d:49c5:: with SMTP id t5mr4143840wrs.18.1592326916028;
 Tue, 16 Jun 2020 10:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org>
In-Reply-To: <20200616074934.1600036-1-keescook@chromium.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Jun 2020 10:01:43 -0700
X-Gmail-Original-Message-ID: <CALCETrVLA22khom-iSu5iTJGKfUykOnwyz8j7Tm9g6hWW_e0Aw@mail.gmail.com>
Message-ID: <CALCETrVLA22khom-iSu5iTJGKfUykOnwyz8j7Tm9g6hWW_e0Aw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, X86 ML <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 16, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>

> In order to build this mapping at filter attach time, each filter is
> executed for every syscall (under each possible architecture), and
> checked for any accesses of struct seccomp_data that are not the "arch"
> nor "nr" (syscall) members. If only "arch" and "nr" are examined, then
> there is a constant mapping for that syscall, and bitmaps can be updated
> accordingly. If any accesses happen outside of those struct members,
> seccomp must not bypass filter execution for that syscall, since program
> state will be used to determine filter action result.

>
> During syscall action probing, in order to determine whether other members
> of struct seccomp_data are being accessed during a filter execution,
> the struct is placed across a page boundary with the "arch" and "nr"
> members in the first page, and everything else in the second page. The
> "page accessed" flag is cleared in the second page's PTE, and the filter
> is run. If the "page accessed" flag appears as set after running the
> filter, we can determine that the filter looked beyond the "arch" and
> "nr" members, and exclude that syscall from the constant action bitmaps.

This is... evil.  I don't know how I feel about it.  It's also
potentially quite slow.

I don't suppose you could, instead, instrument the BPF code to get at
this without TLB hackery?  Or maybe try to do some real symbolic
execution of the BPF code?

--Andy
