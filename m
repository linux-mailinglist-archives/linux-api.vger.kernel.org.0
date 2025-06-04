Return-Path: <linux-api+bounces-3871-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D8DACDDC2
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDAA172659
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6339528E609;
	Wed,  4 Jun 2025 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="yyGRU1qp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82A24DD16
	for <linux-api@vger.kernel.org>; Wed,  4 Jun 2025 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039572; cv=none; b=f3VnHbpe77Ebl6TYESjk3AGoiSxW/XzXUk7R4fz65s5cBwTn0W1dSnwlIiISsrucXcPqNSBH7EqJM6VtBXaY4bobSaMXTDSK3TEoGF3d8iX3pE8flP96SNRn0Q1q4S3NJBMmCtfJQl4T+bnpEKGXyysPEKoJkdXl+fxQl+PX1mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039572; c=relaxed/simple;
	bh=vsTAjMsXxruZD6EGEeDMJx5KZQVmoGJlBxqecOUMPhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4yhP1iyWJ3eIQtXVOQOjvYIzg3r/rdPBLFHJzE42FTUHDDyNCYab41DKDQU70X9TksQs0b/UnvG8y5F0ALT6V4AZaEocuU7LN6/ju8nPcY3o9uHCX0QV9rULmjAh6Wl8bB+dHdHdZeqxaA/S1zo73BgOKuDjN4m8tAg9YKd330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=yyGRU1qp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cf2291bbso25901755e9.0
        for <linux-api@vger.kernel.org>; Wed, 04 Jun 2025 05:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1749039568; x=1749644368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7va4B4zo5RMoE8/q1VOrd2uGJHuIadY3crtc+x7HSIs=;
        b=yyGRU1qpBsaMLBUCgCWNDyAK8xEwbdz5so70/sFtDet0Ccql7H/LSW5A+WjC3xLsKM
         ZKRtmTIVBCnJqApyDK45Yl/pVIKEf8y8C6xdy+fwUxXRBNSSHtSZKGwAKn+LFhDulA+c
         9SjfIeMB9FN1n8Q+T/2zMfdA8qb4KQbpKyAiMCyaEs/1/yPDcZs+rWorZOf/xMsrxAcK
         eaaRlC5OLN0eitm650Xh4kJ+CO/sj/lAOzljGcBGF5QI937h1R+V+rOulnJQZEWudnSI
         gX4CyMoKbmz+OpafNdEHWzwV1qQisiyVEf9k641WzIoV/t1aOiLeMpYh58pgwa4uqpoh
         J/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749039568; x=1749644368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7va4B4zo5RMoE8/q1VOrd2uGJHuIadY3crtc+x7HSIs=;
        b=ciqq4yxR3PaIR1ID2qPfFd1Ct6zd5qunNTtyeNZXImIj2cigqGteG0VY79ls1Ou2eW
         J3QxwvjebuJLtiHrhBv42d+IQyzhbHk0gmEzwpLNstRP2H3JrMx1nAOB7CYGGcoiSsZz
         Wkx6fDq4j2TDyq9DMZ/rnbVbUrRwDdUQ0NFNtw4EjZJIYrUNMQpZpixhvMhe07tuBXZM
         tUVSKN4ofCdV5Ygl9sBbLjwI9Uy7e5GveS8RGSDTgs8e5uZBQevxohUU9NgJqPmvRbTt
         vaM+VvkINoVDhwGiQGzNMSab+3/0z52IT/VpS+GXq1HVGZGif0IGdPeFLlfqdPD1KuLr
         M5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQcUdQJKcy5b0f7Zzx8jqyNuLTrHbde9K6YjK0VKmiVF0R3AnBQVnE5CQa4oOZszkvYZaB634slRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyce7km6NR1Y0OBOQUUrE2hNIN2tSAypnP2AnQE0RAChi4e7XR+
	vjQTPr3bNQFs/3HDRdaUu808YZ1s0anIIZ0t0rnmYFeljKeWEzanZ2Kq5UnFo/HqamA=
X-Gm-Gg: ASbGncsMf0Iw8s0A6CifO70CqtqWPB7Vls52zywqJdKYbGudwkXhecv4n1Osa5M7ioG
	3AX19Wy4loYd/apTajjwLWWGQww3ePThQBP+v03cl2zDtlGIHCLX+vYN69pIUAmTgSiUyGj0Jxg
	kD+ufXrwdgFjBlcmSBKM70pux1TykS/lkK3+wEDVuvENODOzlsHmFkMg4r2QHoOP454R9LrQ7G6
	5LK2SEmCDQOQeNyUcp1dV99VRQkSbb6/M897JcaoeCh+PX8GbVIEzTOXqUQnlLU5xhswBkOLa8m
	GL+vIuuqbQxOBlIoCdOe0m9GYWS6pOOJ3nOaGGfhImIrpDk1
X-Google-Smtp-Source: AGHT+IGVrF4O5T3Kqh+fUs3JsLlwaWKguUlwDSvf4RuehBTzNd19MRzE14XOKWLjuavmnFq2+KnyhA==
X-Received: by 2002:a05:600c:6297:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-451f0aa7fb6mr21810695e9.15.1749039568246;
        Wed, 04 Jun 2025 05:19:28 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:da11:6260:39d6:12c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a5215e4c4asm1456495f8f.17.2025.06.04.05.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:19:27 -0700 (PDT)
Date: Wed, 4 Jun 2025 08:19:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, Barry Song <21cnbao@gmail.com>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>, tj@cmpxchg.org
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <20250604121923.GB1431@cmpxchg.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
 <0aeb6d8b-2abb-43a7-b47d-448f37f8a3bf@suse.cz>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aeb6d8b-2abb-43a7-b47d-448f37f8a3bf@suse.cz>

On Fri, May 30, 2025 at 12:31:35PM +0200, Vlastimil Babka wrote:
> On 5/29/25 23:14, Johannes Weiner wrote:
> > On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> >> Barry's problem is that we're all nervous about possibly regressing
> >> performance on some unknown workloads.  Just try Barry's proposal, see
> >> if anyone actually compains or if we're just afraid of our own shadows.
> > 
> > I actually explained why I think this is a terrible idea. But okay, I
> > tried the patch anyway.
> > 
> > This is 'git log' on a hot kernel repo after a large IO stream:
> > 
> >                                      VANILLA                      BARRY
> > Real time                 49.93 (    +0.00%)         60.36 (   +20.48%)
> > User time                 32.10 (    +0.00%)         32.09 (    -0.04%)
> > System time               14.41 (    +0.00%)         14.64 (    +1.50%)
> > pgmajfault              9227.00 (    +0.00%)      18390.00 (   +99.30%)
> > workingset_refault_file  184.00 (    +0.00%)    236899.00 (+127954.05%)
> > 
> > Clearly we can't generally ignore page cache hits just because the
> > mmaps() are intermittent.
> > 
> > The whole point is to cache across processes and their various
> > apertures into a common, long-lived filesystem space.
> > 
> > Barry knows something about the relationship between certain processes
> > and certain files that he could exploit with MADV_COLD-on-exit
> > semantics. But that's not something the kernel can safely assume. Not
> > without defeating the page cache for an entire class of file accesses.
> 
> I've just read the previous threads about Barry's proposal and if doing this
> always isn't feasible, I'm wondering if memcg would be a better interface to
> opt-in for this kind of behavior than both prctl or mctl. I think at least
> conceptually it fits what memcg is doing? The question is if the
> implementation would be feasible, and if android puts apps in separate memcgs...

CCing Tejun.

Cgroups has been trying to resist flag settings like these. The cgroup
tree is a nested hierarchical structure designed for dividing up
system resources. But flag properties don't have natural inheritance
rules. What does it mean if the parent group says one thing and the
child says another? Which one has precedence?

Hence the proposal to make it a per-process property that propagates
through fork() and exec(). This also enables the container usecase (by
setting the flag in the container launching process), without there
being any confusion what the *effective* setting for any given process
in the system is.

