Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804474562E5
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 19:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhKRSvW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Nov 2021 13:51:22 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:46971 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhKRSvW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Nov 2021 13:51:22 -0500
Received: by mail-wm1-f54.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so5558526wmb.5
        for <linux-api@vger.kernel.org>; Thu, 18 Nov 2021 10:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIRAfzIR/dE/ShBqpWnkAjmlApZ8MXFVwx1D1xo44+Y=;
        b=R4THscZPzEf6gp4tC/C6LY/mOV2JKNMHu2R8dwT0ifUKIcZhiYNTSUe1ei5Y5jIQqN
         HlTEiNoGL+mt4kB/4PjoVL8BUXtwyv2SbhXXbCOgVgAxeXXa98aVP8ojYQHFrsHcr1ky
         4ULhHnVjdpkheH/LbPyeNtdPUFG3JBc5li1IZXNNzmLzwQcy6vcjR0JBbFL5fWE01J6H
         J7PBo7KAxPYdbzHPUAulj1m9zzdcCO6NbUu1R94pljvD0yrjUoPHua+JfHjyEj1UhC6a
         MkrbQ6VzoaSLDxDZWfs/q5Mf9rSuWIAPjip6VVLsW/bYa2gWR+wkGFabkpY4aBvPJrHM
         4pgQ==
X-Gm-Message-State: AOAM530/86NJRZ3hNSO6RqaHQcgiIw1GPTPErwzO54c8PgjyzYiNO7rk
        48NMJoLhwYgUliCbJhhfPgtwb1dbKBaI8H+Yj+kBWg==
X-Google-Smtp-Source: ABdhPJwuK4A1h1UIhd9NnzOZDgF/xFSLWT1RIWX4BZHFWRY/cpmx7oXEKHjcH81DKOApyd6QZEJbqiu1CnJ/qtnD7AQ=
X-Received: by 2002:a1c:2585:: with SMTP id l127mr2929388wml.72.1637261300556;
 Thu, 18 Nov 2021 10:48:20 -0800 (PST)
MIME-Version: 1.0
References: <87wnl5u5rz.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wnl5u5rz.fsf@oldenburg.str.redhat.com>
From:   =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Date:   Thu, 18 Nov 2021 15:48:09 -0300
Message-ID: <CAPBLoAe+KZiM9fb3M7nXXSr_MVGOSQhFWgJYeQH-zXGF3j2cJw@mail.gmail.com>
Subject: Re: Bringing rseq back into glibc
To:     Florian Weimer <fweimer@redhat.com>
Cc:     libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 18, 2021 at 7:17 AM Florian Weimer via Libc-alpha
<libc-alpha@sourceware.org> wrote:

> 4. Add public symbols __rseq_abi_offset, __rseq_abi_size (currently 32
>    or 0), __rseq_abi_flags (currently 0).  __rseq_abi_offset is the
>    offset to add to the thread pointer (see __builtin_thread_pointer) to
>    get to the rseq area.  They will be public ABI symbols.  These
>    variables are initialized before user code runs, and changing the
>    results in undefined behavior.

Why not then __get_rseq_whatwever functions and not variables ? or
maybe writing to these variables results in a compiler or linker error
instead of UB ?
