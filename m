Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761542D828D
	for <lists+linux-api@lfdr.de>; Sat, 12 Dec 2020 00:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405155AbgLKXCr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Dec 2020 18:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387624AbgLKXCe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Dec 2020 18:02:34 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21479C0613D3;
        Fri, 11 Dec 2020 15:01:54 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c79so7918062pfc.2;
        Fri, 11 Dec 2020 15:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bd3lnTouDkrwjjSfW9VflwhzX7QjYlCu/cZFh9AVANo=;
        b=RbYMW87X89+0E07Qfby6qNe/Hi0TJHNKUeKYLJLewGbAACwaLhmCuZd4hrqQC8FuW5
         0v16SGCjiQUHjwYn/npIeSBbBhNzmqG8alz9+qAxfTQRobZ6AaTn1CJ8w19AE9RTKn+Y
         E8ZEDkdalSLFgY62f7Eb+kWmc2EwzxYNbnw98oM/Yf9ifr9MAs2bQg4fu8zSCCtN73CL
         /kM7SnTlPM2Xq9QfYJPejRpbyZgvcSk3nXuQCgV2nFKNyxNgl8pIjtU0HQxKqZ9vcqmP
         YnzA9n6Szqs0G7NN9Pw+k1h5MAdBafQKm7Z1qCvj+nOUrYW+yukm2o6DV0RhH5o0R1WT
         a/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Bd3lnTouDkrwjjSfW9VflwhzX7QjYlCu/cZFh9AVANo=;
        b=TiCGLHJq8l4kvrDqxtJA6txVsB5MaPSAH1hqpJ5DkDul8uumkQEeinORYKZO/MsEGt
         LHz0rLWdBNxO2ALlKk9x0x9u+/M9KSf3lB7k+Zol9sbxBJ+1H0OyTFEP0i2hTSpZnXMR
         vtPnJDzayzq5tD+h1MfMcmOLvims24PwjG/vGyI5le88YFJWo9ffgI2ixfw3IEtS6u19
         CxsKG7qIIQqFIzNyZXc0blATV0g2VUnlnaMLmT2KO2Sw+nfBeqost0j7C8Y9T+hXm9Hl
         fsdC+DufRhsRrCc4HCyJV1k6EbnAyVIajSLyEvH4+cB5OmlVKI4TKiN0DugpEBZaPBFZ
         A4eA==
X-Gm-Message-State: AOAM5329ylXb2eYkM96aWiBEgIiWaZ1s/ZMgRiRHZX9jFsi9YrwD16vQ
        zcKsevuHciue/q3TC+I4ycjGxTej2f8=
X-Google-Smtp-Source: ABdhPJxD9yxxB5VYc/nKY/dyjnea/B4P6Q32nH3WYgZOh71GrQyfK9uwB3k+0CrFgs9ulA4z+Cqd5g==
X-Received: by 2002:a63:db09:: with SMTP id e9mr13977072pgg.60.1607727713688;
        Fri, 11 Dec 2020 15:01:53 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id x4sm11537094pgg.94.2020.12.11.15.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 15:01:52 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 11 Dec 2020 15:01:50 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
Message-ID: <X9P6XuRG1l1Q6zdR@google.com>
References: <20201124053943.1684874-1-surenb@google.com>
 <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com>
 <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 11, 2020 at 09:27:46PM +0100, Jann Horn wrote:
> +CC Christoph Hellwig for opinions on compat
> 
> On Thu, Nov 26, 2020 at 12:22 AM Minchan Kim <minchan@kernel.org> wrote:
> > On Mon, Nov 23, 2020 at 09:39:42PM -0800, Suren Baghdasaryan wrote:
> > > process_madvise requires a vector of address ranges to be provided for
> > > its operations. When an advice should be applied to the entire process,
> > > the caller process has to obtain the list of VMAs of the target process
> > > by reading the /proc/pid/maps or some other way. The cost of this
> > > operation grows linearly with increasing number of VMAs in the target
> > > process. Even constructing the input vector can be non-trivial when
> > > target process has several thousands of VMAs and the syscall is being
> > > issued during high memory pressure period when new allocations for such
> > > a vector would only worsen the situation.
> > > In the case when advice is being applied to the entire memory space of
> > > the target process, this creates an extra overhead.
> > > Add PMADV_FLAG_RANGE flag for process_madvise enabling the caller to
> > > advise a memory range of the target process. For now, to keep it simple,
> > > only the entire process memory range is supported, vec and vlen inputs
> > > in this mode are ignored and can be NULL and 0.
> > > Instead of returning the number of bytes that advice was successfully
> > > applied to, the syscall in this mode returns 0 on success. This is due
> > > to the fact that the number of bytes would not be useful for the caller
> > > that does not know the amount of memory the call is supposed to affect.
> > > Besides, the ssize_t return type can be too small to hold the number of
> > > bytes affected when the operation is applied to a large memory range.
> >
> > Can we just use one element in iovec to indicate entire address rather
> > than using up the reserved flags?
> >
> >         struct iovec {
> >                 .iov_base = NULL,
> >                 .iov_len = (~(size_t)0),
> >         };
> 
> In addition to Suren's objections, I think it's also worth considering
> how this looks in terms of compat API. If a compat process does
> process_madvise() on another compat process, it would be specifying
> the maximum 32-bit number, rather than the maximum 64-bit number, so
> you'd need special code to catch that case, which would be ugly.
> 
> And when a compat process uses this API on a non-compat process, it
> semantically gets really weird: The actual address range covered would
> be larger than the address range specified.
> 
> And if we want different access checks for the two flavors in the
> future, gating that different behavior on special values in the iovec
> would feel too magical to me.
> 
> And the length value SIZE_MAX doesn't really make sense anyway because
> the length of the whole address space would be SIZE_MAX+1, which you
> can't express.
> 
> So I'm in favor of a new flag, and strongly against using SIZE_MAX as
> a magic number here.

Can't we simply pass NULL as iovec as special id, then?
