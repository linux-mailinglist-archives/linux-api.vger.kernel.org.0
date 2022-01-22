Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4A7496D48
	for <lists+linux-api@lfdr.de>; Sat, 22 Jan 2022 19:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiAVSaB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jan 2022 13:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiAVSaA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Jan 2022 13:30:00 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654BEC06173D
        for <linux-api@vger.kernel.org>; Sat, 22 Jan 2022 10:30:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so48502903edj.7
        for <linux-api@vger.kernel.org>; Sat, 22 Jan 2022 10:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KVS5Vv9x4j1rYlAUHDutrpOGh/PFnNue3zM94McKQco=;
        b=kholFSU9WGDaL/0mgovS14dARJabt548SLamMinuPddwYwVdJRCCSLmO1TwfadRZO9
         bCI30s7DEqnwPVnSZuYXuGZpAuitnKfYNWxbnL5Dj7z4yzh90gbmjba5aIVJATxhhxnF
         A7PhNMSYUKRTgnpG/XnU1Lk/mFqyftkzWynXnr/2DeKMXGm0vbqk1aX9GeXl9A7n1TMs
         zK0Y9t7dE3jNTo4QIp3lkW4nOz+ckYfbzbf9XDbcbVChm/yuKhFg6WZY/V2djeS05Qv+
         X3coRp0gpFQMiKaH4Nm1bjM8dRmmq2JbaivIhBdZPkCU4fIobe62NABBKHuux9jRjqlI
         s7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KVS5Vv9x4j1rYlAUHDutrpOGh/PFnNue3zM94McKQco=;
        b=Z+Y18Vx683EnGS17yUWzVEbTGtGlgtnSD8cs9urKwzhUc6fukYNvgznKzwGC/HmBHc
         SzR4eTHsAwnYvmEPkHeHv+u4VUWSPYqNeEg52jVZ7E5JdLMP2jpOuZsHLsBIDwZsx0xW
         byzs0bLzL0scO8zJwDtXnv85HRRLRA1hQM5kgLmgeKCvL1WMITUdxARgnPMX4t5HRfoM
         Mncj3xx/ilUQG4NBlUPs+WHIz2dHF7LGAZxG0+EwlCJiJWeVi7zw39EEwXQGVQxWJVd+
         hHY0dxeLskLCwBNhvAado/BtfGo2RTV41YvjiOYQXVCCjD1gn4bo0TXbWjG9LZWUf6oc
         sliA==
X-Gm-Message-State: AOAM5333QVXqUQwSt41ELQm2ZPrSG9xBft+lPCXdh5F0N+JOs3F8PeQD
        YgTmvt1rfBqx6Nsu+hopbKkAAH+dEUnqY4FgLRajQw==
X-Google-Smtp-Source: ABdhPJxRjsZwdzd5a5cG5hKLAE10zuNJrJIajhUwS3LhZ6WtAz8ve8XMfwHxy+cTCfuabmxgnkTfSZtlmJvuMGOFu6w=
X-Received: by 2002:a50:d709:: with SMTP id t9mr400764edi.50.1642876198379;
 Sat, 22 Jan 2022 10:29:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642526745.git.khalid.aziz@oracle.com> <YevrGs3WE7ywB+lH@kernel.org>
In-Reply-To: <YevrGs3WE7ywB+lH@kernel.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sat, 22 Jan 2022 10:29:36 -0800
Message-ID: <CALCETrWUwn=STQpXZuXpE43UAy_2PeEDkv-FvHU+kCDur2qB9g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        willy@infradead.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> On Jan 22, 2022, at 3:31 AM, Mike Rapoport <rppt@kernel.org> wrote:
>
> =EF=BB=BF(added linux-api)
>
>> On Tue, Jan 18, 2022 at 02:19:12PM -0700, Khalid Aziz wrote:
>> Page tables in kernel consume some of the memory and as long as
>> number of mappings being maintained is small enough, this space
>> consumed by page tables is not objectionable. When very few memory
>> pages are shared between processes, the number of page table entries
>> (PTEs) to maintain is mostly constrained by the number of pages of
>> memory on the system. As the number of shared pages and the number
>> of times pages are shared goes up, amount of memory consumed by page
>> tables starts to become significant.

Sharing PTEs is nice, but merely sharing a chunk of address space
regardless of optimizations is nontrivial.  It=E2=80=99s also quite useful,
potentially.  So I think a good way to start would be to make a nice
design for just sharing address space and then, on top of it, figure
out how to share page tables.

See here for an earlier proposal:

https://lore.kernel.org/all/CALCETrUSUp_7svg8EHNTk3nQ0x9sdzMCU=3Dh8G-Sy6=3D=
SODq5GHg@mail.gmail.com/

Alternatively, one could try to optimize memfd so that large similarly
aligned mappings in different processes could share page tables.

Any of the above will require some interesting thought as to whether
TLB shootdowns are managed by the core rmap code or by mmu notifiers.
