Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A31572EC
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 11:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgBJKfn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 05:35:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33332 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJKfn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 05:35:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so6559185lji.0
        for <linux-api@vger.kernel.org>; Mon, 10 Feb 2020 02:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gBA2mpqc5yNuBwQF0S/7vQMG1htEwiZgSuMMRsfYXAs=;
        b=rSwTITTB+2r28n2Butgc7Bsjdj50BTP4ffGx1My9Imv9wCXcLjgtbxkcwJVYTU95Ef
         XaMMMNinTsqW5qDSvh1u3a16YuEDuFSGP9OzOn8c7yz5ryA7b5UCHRmLQlAKS6mjOUTi
         RN2JoND+a3Oc451cl65w+eSeo3j7CECjTGa70SgqaV2bV1IM4wBNN3h0PJJM28mi66a6
         jSn6txrRpKv72mBZJYUgWIpAJ7mdothPRIiA9ZdgsI2jFewnRyY/ZO1VUiO7A+sYQ7cv
         wo3vIpKcUXJoQ7XNxryqC6kYFRbgPESx8Yx4E8CswvMVNdwnjdVEoy+dPN0srbtCY5Nk
         nXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gBA2mpqc5yNuBwQF0S/7vQMG1htEwiZgSuMMRsfYXAs=;
        b=ubaY+5+lQdiDriSoWh1RgHE0uX+R3uVj9riVTwUlJL7YZr1AKXQasLNu2PCoU1uPAO
         oZSJ1vIFkOHjBEp3rneIJ10iSNqNswD117mLP7opWBrz6JfOAu9X+U+4EywvlPgEBlym
         3XSjR91HO9Th8llZXrZEw/6hmL4S96M5VmgxgfZsoyH9D9IbYBxEfjt5D012t8hGAc2D
         howrAz2IWEO9Ln4q4/ObXCS9LXOl47ht/1mKBiEzffV+sBtHLwGk+1i/a+zPGjqLXsKf
         f37R9YDSuLGw/2dIDTadPmkLTeNmxP7kJv8TnE17m9yirgSYjFyPQ/MIOpZIDH7R6FKR
         jySQ==
X-Gm-Message-State: APjAAAXM5JkF/gXAGV7Ub+TZnG2qSRIQq7meaPrnp0zGqnNFTKE+j2hG
        10/DZ/kSvp8BCCRbTaLHRe/6YQ==
X-Google-Smtp-Source: APXvYqxUtuigBVXmjs6cg4R5cddlet9eURMDw2uVtBl3TeBZ31CaHSWoMuD6/oA10TDgIs101r7shg==
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr494979ljj.265.1581330939239;
        Mon, 10 Feb 2020 02:35:39 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m24sm7474324ljb.81.2020.02.10.02.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 02:35:38 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E79D4100B0A; Mon, 10 Feb 2020 13:35:56 +0300 (+03)
Date:   Mon, 10 Feb 2020 13:35:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
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
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200210103556.wz72op4g554qn5jm@box>
References: <20200123014627.71720-1-bgeffon@google.com>
 <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box>
 <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
 <20200129104655.egvpavc2tzozlbqe@box>
 <CADyq12xgnVByYOkL=GcszYYKzDpg254QEOFoW8=e1y=bmOCcFQ@mail.gmail.com>
 <20200203130940.enfvdsbn42hhoaki@box>
 <CADyq12x98QspiWSqNui1OH8+FEUzVyJwxia+ho00S2+Q+PmTjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12x98QspiWSqNui1OH8+FEUzVyJwxia+ho00S2+Q+PmTjw@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 07, 2020 at 12:42:15PM -0800, Brian Geffon wrote:
> Hi Kirill,
> I started a new thread https://lkml.org/lkml/2020/2/7/640 for my v4
> patch. But I wanted to quickly address your comments. Regarding the
> concern around the rmap, no changes actually need to be made. If we
> were to unlink_anon_vma(vma) and then set vma->anon_vma = NULL, that
> would be fine but then as soon as there was a fault the same anon_vma
> would be attached since it's a private anonymous mapping. So there is
> really nothing to do regarding the rmap.

Okay.

My worry was that we create a new VMA with the same anon_vma *and*
vm_pgoff, but I just realized we can do the same with the current
mremap(2) plus following mmap(2) in the old place. So it's not regression.

I guess we are fine here.

> I considered the two flag approach but since I could not come up with
> a concrete use case of MREMAP_MUSTMOVE I decided to just leave the
> single MREMAP_DONTUNMAP flag, the two flag approach would be only for
> clarifying the operations so I'm not sure it's worth it. (Still trying
> to come up with a better name). But I've attached a man page diff to
> the latest patch.

At least it doesn't have 'FIXED' semantics forced on user. It's fine with
me.

-- 
 Kirill A. Shutemov
