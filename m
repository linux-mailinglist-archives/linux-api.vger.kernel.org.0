Return-Path: <linux-api+bounces-1738-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76FE90925A
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2024 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AAA287C9B
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2024 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4019D07D;
	Fri, 14 Jun 2024 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i2ipNGHT"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3261474C5;
	Fri, 14 Jun 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390151; cv=none; b=DqUIHcjZowkpPwjS1sZNNbIhOsCWptcaWrvbb3S7sUWPomeUArb1z0EnPsQw7fXJbM3q4exdbv8wDS3RVDkbG4+UImgaiBcE7zgt3lpYtnVqFbiA7PvvxjasUsba0LtNQ00IzwKqc6YH9NS3U4RK1Ff1FWAVU+8j5z+LH2LbS7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390151; c=relaxed/simple;
	bh=B5jYTOQBgQdD5aRhMO45Czl8lxa5eGSnENsV3D2nZZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWdkbP/8taHV0uMVsozDNCo6RYxwJe34kQ7P2SHoHdJF6tsP7I0xmPVFX/ip8Lm/fLUy5luDwfAmGWcfWoke2TPwgyJu1fBm/JMtlAm+CN9HkgseRbJ132KzS+Y7oy2KUBqv7YFebISAeoIgRNkUI/cnB8wZxARcoO454biTfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=i2ipNGHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C632C2BD10;
	Fri, 14 Jun 2024 18:35:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i2ipNGHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718390147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N8EBuid4q80uW/eoYI4M6BiKa1dNh0P0MAOlhzYgkd4=;
	b=i2ipNGHTfG1yOnnWQvVlSDsyrAeQEvUAWla+HRxu/DiTW3T7+Y4kwVuoIMmNzkw1PlMGd7
	AmeJxKG83pPFRHG1XKQu7RO81WyznGuwBQPH0/8GOE7GtYvaR2CsuAq6o8PPlSbqqQ3Kqs
	dS8XBbw26hYntiX1TuaVCe6Tqdk8c5E=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d10b8049 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 18:35:46 +0000 (UTC)
Date: Fri, 14 Jun 2024 20:35:38 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, tglx@linutronix.de,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZmyNemDma0bK_V8J@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-2-Jason@zx2c4.com>
 <CAG48ez0P3EDXC0uLLPjSjx3i6qB3fcdZbL2kYyuK6fZ_nJeN5w@mail.gmail.com>
 <Zlm-26QuqOSpXQg7@zx2c4.com>
 <CAG48ez3VhWpJnzHHn4NAJdrsd1Ts9hs0zvHa6Pqwatu4wV63Kw@mail.gmail.com>
 <ZmMamtll1Yq1yfxc@zx2c4.com>
 <CAG48ez0pan8aLGjHtoDdrpiP+e5YrGeuD_RzDXgzUwkUvWYLjA@mail.gmail.com>
 <CAG48ez1k0J013tYLfmnT8NXRpG_5BR10xnH8r-yRvTLpJe-nLA@mail.gmail.com>
 <Zmbq1dGPIYdRLw5_@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zmbq1dGPIYdRLw5_@tiehlicka>

On Mon, Jun 10, 2024 at 02:00:21PM +0200, Michal Hocko wrote:
> On Fri 07-06-24 17:50:34, Jann Horn wrote:
> [...]
> > Or, from a different angle: You're trying to allocate memory, and you
> > can't make forward progress until that memory has been allocated
> > (unless the process is killed). That's what GFP_KERNEL is for. Stuff
> > like "__GFP_NOWARN | __GFP_NORETRY" is for when you have a backup plan
> > that lets you make progress (perhaps in a slightly less efficient way,
> > or by dropping some incoming data, or something like that), and it
> > hints to the page allocator that it doesn't have to try hard to
> > reclaim memory if it can't find free memory quickly.
> 
> Correct. A psedu-busy wait for allocation to succeed sounds like a very
> bad idea to imprint into ABI. Is there really any design requirement to
> make these mappings to never cause the OOM killer?
> 
> Making the content dropable under memory pressure because it is
> inherently recoverable is something else (this is essentially an
> implicit MADV_FREE semantic) but putting a requirement on the memory
> allocation on the fault sounds just wrong to me.

The idea is that syscall getrandom() won't make a process be killed, so
neither should vgetrandom().

But there's an argument to be made that the NOWARN|NORETRY logic only
made sense with the now-dropped "skip instruction on fault" patch that
was so controversial before, since in that case, there wouldn't be
infinite retry, but rather skipping and then falling back to the
syscall. I think this is nicer behavior, but the implementation caused a
stir, so I'm not at the moment going that route. Given that, I think
I'll follow your advice and get rid of NOWARN|NORETRY for this too. And
then maybe we'll all revisit that later.

Jason

