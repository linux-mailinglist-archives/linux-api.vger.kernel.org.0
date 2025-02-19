Return-Path: <linux-api+bounces-3252-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D284EA3C7FD
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2025 19:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18F11898AC2
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2025 18:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1417214A7F;
	Wed, 19 Feb 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5Thh6vI"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEFA1E4AB
	for <linux-api@vger.kernel.org>; Wed, 19 Feb 2025 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991138; cv=none; b=nU7+v0KXw4JWnTBc6blJneQw486ARC5th4WBLO+z7mXIuDAi3kBa+uUIF9IE6GGxFeYvZ8aoLydOZwQsmMhoQuvzh5Z1124MboAfku/DwlHmSMJH3LWGsTLKUEJ9PcJA2V+5GXZCsHSMmnboK9giFnKnbMrT0TjDkc9hntzX/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991138; c=relaxed/simple;
	bh=wcD2OY6TqU0MtXZVRtiMEPyv+P7BaI1CEM+zQ7fXeKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQcSbSnoqw7vxi90j2DPofIo+VtdmDCj46JpnAogOeDcJSl8VDP/RN+qyl1s80y9pYJQhdhzWTw0UZ6E3IQulNz54TkceCjLoFtZw3ao2UEj+BQDYXClq4iTI0EIN2OHUO0KBG8ss7RcUsy8bNvrt365UoelpyCWbJ2ZDVOQWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5Thh6vI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22117c396baso14245ad.1
        for <linux-api@vger.kernel.org>; Wed, 19 Feb 2025 10:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739991136; x=1740595936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcD2OY6TqU0MtXZVRtiMEPyv+P7BaI1CEM+zQ7fXeKU=;
        b=S5Thh6vIzcAdf21rmY0gyr3d2gFpkYOx243CDV4vbpYqkpqeO/TlhgkugExvppJwUH
         ygg9YPR/IrC/52tWf8k6zBzhUk6OXaaEktEqJP/ab9oUXH5OB+1hctKQCACl/4SfVhyU
         0OsZBUE32DGHxUFSitPD79Gl3nKmqaOExCMpuWEwY5ixN1zOzWjMz67uqhJ2+mPimnh8
         ZOVmh3CTJdME3FFRSCYer1z5ymN65E9+5l8uijae/DIN4iH5yhPzd495lq/9EQdsPRIp
         D3y7x9pslPZF4KOWLoQ2YkKba9cElYaKTFrEbxTd/nqmZ0LW/JiV7Z7Ns8WoucsYgYVt
         Whzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739991136; x=1740595936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcD2OY6TqU0MtXZVRtiMEPyv+P7BaI1CEM+zQ7fXeKU=;
        b=AJULT00mFXVtvTiO5HMSK7r116UuNoooWxzWY2fkjmulVEBHaDzcDCXfe9k4Zn5Xuv
         MON3p9AAxMHT68csgUWvSJZ6X/CfkJEAc7nFR44XMSn7b2Dnp2RX8Wp0BP6DV7xCUcDd
         KIRRHHKr2hJjOH4trlmMDHpxcp7HGpAVSirLwuahE3Ebhoy2sDSHEueCxgYc2Wr33ZOK
         9iFgSdn0g2BBDwPBfBayE8cqMUbQkIV4RRDilOabR7BcV7cX6q6cCZOa6K1SqFGl8yCK
         kQKlJDlapte5EzY1YmlXTez1IwjZ2Zmn/VofUthMJxnM+wHqIIOv5sKo+SZyk8SsDTcy
         xGYw==
X-Forwarded-Encrypted: i=1; AJvYcCXuLKF8/UookAakk1sG4PjZR6qmQSgLBHFDldLDI5MVJMVXcqkpV3wp+JxVoCcqIGrPW9xEd/wiA8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0dSB8IGJAd5EfdLBohV3ODFacCZMF2IDB9ghrUNdLqJgYCd1c
	jYLWdpSCiS5giruBUocLP4/mKOWzNWg6nrtw1yRp5lRRj9Poiq7MrqHZhSGB6fsx40HWP4ZmOyX
	KxGhZ/DCekvroY1QgGdvxEAllCKB8DfsSICw2
X-Gm-Gg: ASbGncshllbqW4+DCByrptEt2bpg2SYpPunEfP70+H07dtHjWvfmDPzEB+bl0HYMIur
	pQ7WjD1vx0xKjFU1Zqh4VlsD+YeGzFuzG0gX20wdPevV5oehcLZmUX7BgQi8vqJWzHWw4YAtcz+
	G/o7GDapD1DzijBdTLH+94S4+6tko=
X-Google-Smtp-Source: AGHT+IHllOv/cA5pCN8NUTdnTUDAc13ch3qVkhVXnm87gBSv+gZjArMZqsuk6ANBMTbf+u7AL6UCc15z80Q4w3bHvEg=
X-Received: by 2002:a17:903:234a:b0:216:607d:c867 with SMTP id
 d9443c01a7336-2218e124af4mr16865ad.29.1739991136034; Wed, 19 Feb 2025
 10:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local> <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
In-Reply-To: <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 19 Feb 2025 10:52:04 -0800
X-Gm-Features: AWEUYZlgAIPWYOaVEJVknMRVD_9aoQXv-WWi6eAsmm_A9LcKB1_-iA2G2pXLn74
Message-ID: <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 1:17=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Feb 19, 2025 at 10:15:47AM +0100, David Hildenbrand wrote:
> > On 19.02.25 10:03, Lorenzo Stoakes wrote:
> > > On Wed, Feb 19, 2025 at 12:25:51AM -0800, Kalesh Singh wrote:
> > > > On Thu, Feb 13, 2025 at 10:18=E2=80=AFAM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > The guard regions feature was initially implemented to support an=
onymous
> > > > > mappings only, excluding shmem.
> > > > >
> > > > > This was done such as to introduce the feature carefully and incr=
ementally
> > > > > and to be conservative when considering the various caveats and c=
orner
> > > > > cases that are applicable to file-backed mappings but not to anon=
ymous
> > > > > ones.
> > > > >
> > > > > Now this feature has landed in 6.13, it is time to revisit this a=
nd to
> > > > > extend this functionality to file-backed and shmem mappings.
> > > > >
> > > > > In order to make this maximally useful, and since one may map fil=
e-backed
> > > > > mappings read-only (for instance ELF images), we also remove the
> > > > > restriction on read-only mappings and permit the establishment of=
 guard
> > > > > regions in any non-hugetlb, non-mlock()'d mapping.
> > > >
> > > > Hi Lorenzo,
> > > >
> > > > Thank you for your work on this.
> > >
> > > You're welcome.
> > >
> > > >
> > > > Have we thought about how guard regions are represented in /proc/*/=
[s]maps?
> > >
> > > This is off-topic here but... Yes, extensively. No they do not appear
> > > there.
> > >
> > > I thought you had attended LPC and my talk where I mentioned this
> > > purposefully as a drawback?
> > >
> > > I went out of my way to advertise this limitation at the LPC talk, in=
 the
> > > original series, etc. so it's a little disappointing that this is bei=
ng
> > > brought up so late, but nobody else has raised objections to this iss=
ue so
> > > I think in general it's not a limitation that matters in practice.
> > >

Sorry for raising this now, yes at the time I believe we discussed
reducing the vma slab memory usage for the PROT_NONE mappings. I
didn't imagine that apps could have dependencies on the mapped ELF
ranges in /proc/self/[s]maps until recent breakages from a similar
feature. Android itself doesn't depend on this but what I've seen is
banking apps and apps that have obfuscation to prevent reverse
engineering (the particulars of such obfuscation are a black box).

> > > >
> > > > In the field, I've found that many applications read the ranges fro=
m
> > > > /proc/self/[s]maps to determine what they can access (usually relat=
ed
> > > > to obfuscation techniques). If they don't know of the guard regions=
 it
> > > > would cause them to crash; I think that we'll need similar entries =
to
> > > > PROT_NONE (---p) for these, and generally to maintain consistency
> > > > between the behavior and what is being said from /proc/*/[s]maps.
> > >
> > > No, we cannot have these, sorry.
> > >
> > > Firstly /proc/$pid/[s]maps describes VMAs. The entire purpose of this
> > > feature is to avoid having to accumulate VMAs for regions which are n=
ot
> > > intended to be accessible.
> > >
> > > Secondly, there is no practical means for this to be accomplished in
> > > /proc/$pid/maps in _any_ way - as no metadata relating to a VMA indic=
ates
> > > they have guard regions.
> > >
> > > This is intentional, because setting such metadata is simply not prac=
tical
> > > - why? Because when you try to split the VMA, how do you know which b=
it
> > > gets the metadata and which doesn't? You can't without _reading page
> > > tables_.

Yeah the splitting becomes complicated with any vm flags for this...
meaning any attempt to expose this in /proc/*/maps have to
unconditionally walk the page tables :(

> > >
> > > /proc/$pid/smaps _does_ read page tables, but we can't start pretendi=
ng
> > > VMAs exist when they don't, this would be completely inaccurate, woul=
d
> > > break assumptions for things like mremap (which require a single VMA)=
 and
> > > would be unworkable.
> > >
> > > The best that _could_ be achieved is to have a marker in /proc/$pid/s=
maps
> > > saying 'hey this region has guard regions somewhere'.
> >
> > And then simply expose it in /proc/$pid/pagemap, which is a better inte=
rface
> > for this pte-level information inside of VMAs. We should still have a s=
pare
> > bit for that purpose in the pagemap entries.
>
> Ah yeah thanks David forgot about that!
>
> This is also a possibility if that'd solve your problems Kalesh?

I'm not sure what is the correct interface to advertise these. Maybe
smaps as you suggested since we already walk the page tables there?
and pagemap bit for the exact pages as well? It won't solve this
particular issue, as 1000s of in field apps do look at this through
/proc/*/maps. But maybe we have to live with that...

We can argue that such apps are broken since they may trip on the
SIGBUS off the end of the file -- usually this isn't the case for the
ELF segment mappings.

This is still useful for other cases, I just wanted to get some ideas
if this can be extended to further use cases.

Thanks,
Kalesh


>
> This bit will be fought over haha
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

