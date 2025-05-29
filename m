Return-Path: <linux-api+bounces-3860-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49AAC84DB
	for <lists+linux-api@lfdr.de>; Fri, 30 May 2025 01:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634F8A274A5
	for <lists+linux-api@lfdr.de>; Thu, 29 May 2025 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0722D9E4;
	Thu, 29 May 2025 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HyH5Ogtv"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548221FF31
	for <linux-api@vger.kernel.org>; Thu, 29 May 2025 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748560480; cv=none; b=mkrNW6vdkC6NNfZ9ZlA6368RkDugJqyXZs7RvEVEdyYFTlgSh0H/vvCdXzcjLmuAXnuOSN13NO3dPRRTsbfrpEjZvQuyXkNqsW+vExwR2FOmr6hm53PKq5C7kM3SaQoiZ8NxyeyjkTpM20BJZ2oETvyaaD/8+WAy01V4+cIB/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748560480; c=relaxed/simple;
	bh=82aH58/OR0lhXutdEGfFFolRSVqVk4YWdp/gYCJthhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geqo4juA8fChaIimykb4NoU4wnA/ExBPnEyh+l979YDThh52i8HCgYtT3kqbEdli8XO32JV4Mz3sW4HxM4oFlECxPUgdnWeVp86mbzz366A6bqvtIqOXtJ3xk6Rh4T3CzdXVvQQrcjaUe3S7aXP9Qf6YyfNFkVxIU236YuxxWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HyH5Ogtv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47686580529so13433771cf.2
        for <linux-api@vger.kernel.org>; Thu, 29 May 2025 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1748560477; x=1749165277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/B8M5wTYZuijeurw8QK1WHO/ILS2jrTlhZFmFoRTN/Y=;
        b=HyH5Ogtv/bAKYdeGFzkyKULzvcWBQ61X3a0HjhTxtCLXQX0Bl0xKR9BEh0KGoKMKSj
         otczVuO2br0wmF2rFklkafmoV0hxzHen4tYQB9A/FsAJb8nBmfJlVKYIZg+1sB95cCOq
         Zy9Q9DW18+JYlsFZApL8iyVmqLn1Jgfg9thXFshmBAr1PgBakIgGdh4tymdC91HRIoY5
         sRQtefrELhWmW67eLkro/GffOiRU3/bxcF9wZZqXQeXPPAPmhqIU0f7y54/VnOF5w1o1
         VoZAc+xqNcLdkQ/bGRjCfsPrOKVrRPlmlfBSXQxdoeUUE2Y8Be3oxDifdR42JMvqka5x
         MhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748560477; x=1749165277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B8M5wTYZuijeurw8QK1WHO/ILS2jrTlhZFmFoRTN/Y=;
        b=VtrePzO3X7P21lky13243vSK5X5GNFU7J1wmUSE79uKD7PjSP+2zjd2YRWx+0t2XRX
         goOcTZRR4H57DUmBGz0nA1H+jIYqLYIhVrVwvNon7Ktj2XanD5yn20ROQai5fB0R/5H0
         At2IG3KxtHeBUICLg7WzgeHQc2TYDN80x26iLqFM0gxKj4ZJ9KwSmcwBfDxmbr5NUf1F
         Pm2U+bg5dRDbyYdMsehMc8U2pS/YoPQkVDu6muOnoM79DkADhIZIqS6XJtyy5laiG0Ve
         m3iicfowakq+y/49AKFG6DlF1aM1SnrYwtZQv/ppdKV/HTMPa+JUmT7OpgJXPmyko+Bt
         l7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFti6/c5W2qyc+DR6o+OgQir4R1AlipdIJaKr1nOYklHQLN/BQCHLdmyjs5fzpiulPhup5VA/PxbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkydDeuaP9KKwClgG+XSX8ZmaPigWvDSBGrYDvyAFnmF/Vo9o
	UVuw0ZJ+CoDlfBF/pBKQVurOdMFPKUKZL56mRxIon06J2rqRlXpl+nEbulPuRD6yeMQ=
X-Gm-Gg: ASbGncvbkN5ftu7O4QqjQKnAw2fVyqKWfvCcuPoT8ME6AybjC2C4r/hEeIH6XQoig6W
	STBwuLb9NXuYdpUDcRQWhCNrKE03qYsTa6HuaoKodz8F8YDwzq5ENF0UoeHSDQGrXY+bDBAmhJy
	C08L5rQ2mBwPB9KEGfTwkGY0Kafk3j0CNJ4uaaMk9MkfOgoyvClGV4hPn4HVRjD+3rGE4osyUgx
	5krVea9V98bc9YpSvnPv/yqs8xSBBH99A447dvTquLhAtHxHMy87nBrrXWvDqdV2RvJqy3duTay
	1/4UKrLYyQCsm3mCcBIHWJzyG9QYkTzZJKvE7mOE+ZnRen8jdA==
X-Google-Smtp-Source: AGHT+IH39k+/aVil5iL6wSfx1rri1NcKXfcLj3pE16Pc8yYjcX2Yvk9Lsla/f5OW48LamZwx8C0WJg==
X-Received: by 2002:a05:622a:608f:b0:4a4:3924:96b9 with SMTP id d75a77b69052e-4a4400e2419mr23361561cf.52.1748560477322;
        Thu, 29 May 2025 16:14:37 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a435a377f1sm12758531cf.61.2025.05.29.16.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 16:14:36 -0700 (PDT)
Date: Thu, 29 May 2025 19:14:32 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, Barry Song <21cnbao@gmail.com>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <20250529231432.GB1271329@cmpxchg.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
 <klrw3rjymes6phs5erz7eqkjji5oe3bg4j4jbqpjv3qzuw4vra@k6ei5pssfany>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <klrw3rjymes6phs5erz7eqkjji5oe3bg4j4jbqpjv3qzuw4vra@k6ei5pssfany>

On Thu, May 29, 2025 at 05:24:23PM -0400, Liam R. Howlett wrote:
> * Johannes Weiner <hannes@cmpxchg.org> [250529 17:14]:
> > On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> > > Barry's problem is that we're all nervous about possibly regressing
> > > performance on some unknown workloads.  Just try Barry's proposal, see
> > > if anyone actually compains or if we're just afraid of our own shadows.
> > 
> > I actually explained why I think this is a terrible idea. But okay, I
> > tried the patch anyway.
> > 
> > This is 'git log' on a hot kernel repo after a large IO stream:
> 
> Can you clarify this benchmark please?
>
> Is this running 'git log', then stream IO, then running 'git log' again?

Yes, but it's running git log twice first. On the vanilla kernel this
is the number of references when we usually activate.

You can substitute any sequence of commands that would interact with
the git objects repeatedly before a pause where programmer thinks.

You can probably get similar mmapIO patterns with sqlite, lmdb, etc.

Periodically running executables and scripts are another case. They
tend to be less latency-sensitive I suppose, but would still
unnecessarily eat into the available IO bandwidth.

