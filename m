Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39D2155FF5
	for <lists+linux-api@lfdr.de>; Fri,  7 Feb 2020 21:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBGUmo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 7 Feb 2020 15:42:44 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36645 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGUmo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 7 Feb 2020 15:42:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so967394edp.3
        for <linux-api@vger.kernel.org>; Fri, 07 Feb 2020 12:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qme74oUO2AjF1HKgLPSJvL4CSEChV51xdiVyhj0IraY=;
        b=bvdo489WkazsFr8MyNsmtfFBn7DsQljQXJ/HOxxSWabU4r6rIEsNpz737+aAgQboHv
         1gx4Yxk1LbZYkC1W9yfgri+0wFxWOnx8qJ7BuCUbOGkyCIMgZwhZlLN8gGCOhRb/SeqT
         q4Y20cVFpjN7cHiDrws7RJEuz+CgdcIfo5GiOF/ezfmFqGAoj6+A4t3f2KUfZBo6LCAM
         TrQGLfTWFH/fwntXGaEhHmzCqCf33+HAfHS28QIf3nfNr7iKy1yp4pWofrcOB8fC5lRW
         CQL5fCArFohre7uLi8GcE8/5B6mcBcK87J7IAYiICzOary8Eqlj4kD4YSxN9f4yVxSKG
         VsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qme74oUO2AjF1HKgLPSJvL4CSEChV51xdiVyhj0IraY=;
        b=clqPdPmt5ZW7Ra2L+jZm9QK43n2GcFXOvK8OCmPWQq0A86F40dujdJ/dvWbfuXhIsZ
         RCKHRytCFM/MZxWAhuK7BeSXFsn8ZnCArZC+prHAcQO+/V+ZeZhY5lLRfGqhOrQuOl9S
         XjJVAHZlcilkp46aaOHfX7ZmrP39auTWTkWWOHWkraTfx43sV92nhj8kEdLwUwJ0Fl/i
         VGvOZtzohaYJ/b0au2baTs8XVq91Gq4FjOP7nE57RYPWsFDiwAUn56LvEQB7TouWMOpq
         1gVryV8ylcuAal+DRtFRuhx8d1MVYIchVPrHa3sglsG+IxfPZa6rLDaMs819dP4Lkk/M
         wK1g==
X-Gm-Message-State: APjAAAVsBtbJVMIsa6VBQ1I+UzDa8trrPBfMb+FeTnni3ou1wkAK4j56
        Bs+D596PIPRpjYIZb9MeZLY1q9arxUk0NMrArG+uGg==
X-Google-Smtp-Source: APXvYqxd/3AgJCgsBd9lmKhLRCgoBs7ng3LZam3gp52WRCLUPvXrvw3OIwH4OX3lHJRvQnfg33LmrMwxq7BZX3LCu1k=
X-Received: by 2002:aa7:d355:: with SMTP id m21mr690593edr.312.1581108161876;
 Fri, 07 Feb 2020 12:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box> <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
 <20200129104655.egvpavc2tzozlbqe@box> <CADyq12xgnVByYOkL=GcszYYKzDpg254QEOFoW8=e1y=bmOCcFQ@mail.gmail.com>
 <20200203130940.enfvdsbn42hhoaki@box>
In-Reply-To: <20200203130940.enfvdsbn42hhoaki@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Fri, 7 Feb 2020 12:42:15 -0800
Message-ID: <CADyq12x98QspiWSqNui1OH8+FEUzVyJwxia+ho00S2+Q+PmTjw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Kirill,
I started a new thread https://lkml.org/lkml/2020/2/7/640 for my v4
patch. But I wanted to quickly address your comments. Regarding the
concern around the rmap, no changes actually need to be made. If we
were to unlink_anon_vma(vma) and then set vma->anon_vma = NULL, that
would be fine but then as soon as there was a fault the same anon_vma
would be attached since it's a private anonymous mapping. So there is
really nothing to do regarding the rmap.

I considered the two flag approach but since I could not come up with
a concrete use case of MREMAP_MUSTMOVE I decided to just leave the
single MREMAP_DONTUNMAP flag, the two flag approach would be only for
clarifying the operations so I'm not sure it's worth it. (Still trying
to come up with a better name). But I've attached a man page diff to
the latest patch.

Thanks,
Brian

On Mon, Feb 3, 2020 at 5:09 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sun, Feb 02, 2020 at 05:17:53AM +0100, Brian Geffon wrote:
> > On Wed, Jan 29, 2020 at 11:46 AM Kirill A. Shutemov
> > <kirill@shutemov.name> wrote:
> > > Any better options for the flag name? (I have none)
> >
> > The other option is that it's broken up into two new flags the first
> > MREMAP_MUSTMOVE which can be used regardless of whether or not you're
> > leaving the original mapping mapped. This would do exactly what it
> > describes: move the mapping to a new address with or without
> > MREMAP_FIXED, this keeps consistency with MAYMOVE.
> >
> > The second flag would be the new MREMAP_DONTUNMAP flag which requires
> > MREMAP_MUSTMOVE, again with or without MREMAP_FIXED.
> >
> > What are your thoughts on this?
>
> Sounds reasonable.
>
> MREMAP_DONTUNMAP doesn't really convey that you move pages to the new
> mapping, but leave empty mapping behind. But I guess there's only so much
> you can encode into the name. (Patch to the man page should do the rest)
>
> --
>  Kirill A. Shutemov
