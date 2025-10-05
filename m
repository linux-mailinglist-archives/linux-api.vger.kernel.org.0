Return-Path: <linux-api+bounces-4996-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5720EBBCE0F
	for <lists+linux-api@lfdr.de>; Mon, 06 Oct 2025 01:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1677C4E1173
	for <lists+linux-api@lfdr.de>; Sun,  5 Oct 2025 23:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC221E1E1C;
	Sun,  5 Oct 2025 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KAt6JuNa"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D741D90DF
	for <linux-api@vger.kernel.org>; Sun,  5 Oct 2025 23:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759707505; cv=none; b=j6Zba5CqQbEp1gEQhEEBp6czHBNlI88CCCPMveZrdjJl65OUX+UlLNW39UIhLx0LI9D6Wu8x6duYO0DDKsEPNezI2zG+WtN5zvryQ3Em2EFkfLNfUXcmQpnedqlizLwNNGmhuYMzc9jUIKPyyqfZjCoO8qFvIMKDAtyVB9XGEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759707505; c=relaxed/simple;
	bh=ZeL8g3+NIGghkoED2HmChwuHilgupZ9KQh+zbVphGW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L34ZPpuRDfZIMCSVcWkoNAEPTiNZhv1sfZKvp32dR6Z1WMaUKV1iywgApWRg65MioFmOTjV5lEgECjCOHiJghNupAGCbPMJQ6xOE1kFzC8BEWaXRJvUiRiHDv09xI/lU8lgHpq/Vj0Plm1jIpbo2wRa3uFzYuKoZh1Fs+yr5Ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KAt6JuNa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78a9793aa09so5044581b3a.0
        for <linux-api@vger.kernel.org>; Sun, 05 Oct 2025 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1759707503; x=1760312303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYZUqfHCkY9qWTGMyfXAR/EXot/02oxeQhh+iKW+hV4=;
        b=KAt6JuNao17F0KLky6jysffcgeHqsYte1hgupMEyzH9N/l8yrthDpUQLwB/ftz1DU5
         xH+fgRIscd9OYV19/pkQs/Jeolq8Uq3nb38twgr4C7wk21xz6GZNUNWh204Wb09SxGU2
         l9Ers5x4rb4uAqYqzYYZ86sX4ZNdzISF458bvUu6SXrqLFpeKkIbCAIhx3MHI1z7MT/v
         nrkvhgVFzNAS4H3dN9pKr30BOk6dd6Daf5BGMXdnLgeVOipgJ1UK/53DxvHeevoFxxT2
         XV2ojKqHSW/Kj+coRzd+B3hBCFw/FK9RB0+lRxzTA9TmHnmjCgibOKMng2GdvsCIudXX
         1Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759707503; x=1760312303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYZUqfHCkY9qWTGMyfXAR/EXot/02oxeQhh+iKW+hV4=;
        b=dKlejMEVYL3dIN8/YPjevs7dwMU1PGVjc1/DRbg4yGq27pjuzSIC/4Vmlj4k6EqA3G
         8cB8db+XuMuNDEPcHayks4tU1g2OJZaAhX9pZ1aYKSnWuux1OoijJ0bsSxauT/5IuhL1
         PGNfrkTqSPJ6+gIrUP+/VpjhENMYUgU/1fBlubAqOv3UiYCxSIQy7AdExUIFOc5Jn9A0
         yN0DVDq3wQGZXyHmGQHzQOr+fSV46edUJsZ+X8GdMCNbZ33Qd17+7Nbq7e9IAMvmeHj4
         Jxwy6HCztdJAT+ZZgOPUKWY+l7mFHBKoWvw7NnQTzEnB5RVxku+78XExBGLkSCQaL+B3
         K0vg==
X-Forwarded-Encrypted: i=1; AJvYcCXL1wPQ0g+H+1BeboJj33uuvm0Pl8OwzvTWa7ZyJJ+Ais3YoZnDfrkrSJ76SPPa8gRPnhkY88RKXEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMYyWSuzzyfsQTsahgDdAYfQPO+7fsGEGA8hl1DX8v7YGW8Mo
	3kOT3plkiFmCwB1qZfEkKvc7DfDz3JswFMjhOO8M3KjAXXPnCoLyAtEDX8ZYRBlgfHY=
X-Gm-Gg: ASbGncuAUPqFpJKp0KdcXSD5cDukh1iSXZM8YUhLBJsdFoFYMKVLfNw5Tk4W++4Rlzp
	rXmbbYvnIX3twioDY/1wPZVjE19OcYvVjaWj/c0GXAQNtiMarLmC4qFw+uT5wrwsjW7xOuoSyu7
	ztTKtW2do/lC8Z2CDd5C3oWCSrHTb/7etkPdOy+e7QMh1JPvN7t9rlbDTlu7ONe8vzR3uqpJn++
	CGbHFqfkpPE6U5grxItUve5dycOuOuDLAjO6TyaKdFFc1jeVOQyhCJNsr0v1AbLuuBBw0iEDCOU
	6fdaPGP5EaB/Wg9aV6Uc1oVFyqh89lhOgF5+kmbcXLVfDaqfeHvkSeACosNMDgROBNU1g4+pb6n
	6Wfgg2whFeKGqdkA92/6zdVh5AhRKWwBkgibyDsLoeZQPuZfBTGANZuDL+8lrS4aTqIslehx4tN
	C44L2I0ARI86jCwuzrlHx+UA==
X-Google-Smtp-Source: AGHT+IHsY0pPmwLcFhMINPZMciPWEOHQAe8XZcWIZ+42Ncu6X7pq8uNjulttyDUGl4xm8ixxs91eVA==
X-Received: by 2002:a05:6a00:39a6:b0:77f:11bd:749a with SMTP id d2e1a72fcca58-78c98cb7834mr10735744b3a.20.1759707503195;
        Sun, 05 Oct 2025 16:38:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020537e0sm10861937b3a.56.2025.10.05.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 16:38:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v5YJ2-0000000B2DA-1HKV;
	Mon, 06 Oct 2025 10:38:20 +1100
Date: Mon, 6 Oct 2025 10:38:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org,
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing
 O_NOCMTIME
Message-ID: <aOMBbKUlvv2uYLzD@dread.disaster.area>
References: <20251003093213.52624-1-xemul@scylladb.com>
 <aOCiCkFUOBWV_1yY@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOCiCkFUOBWV_1yY@infradead.org>

On Fri, Oct 03, 2025 at 09:26:50PM -0700, Christoph Hellwig wrote:
> On Fri, Oct 03, 2025 at 12:32:13PM +0300, Pavel Emelyanov wrote:
> > The FMODE_NOCMTIME flag tells that ctime and mtime stamps are not
> > updated on IO. The flag was introduced long ago by 4d4be482a4 ([XFS]
> > add a FMODE flag to make XFS invisible I/O less hacky. Back then it
> > was suggested that this flag is propagated to a O_NOCMTIME one.
> 
> skipping c/mtime is dangerous.  The XFS handle code allows it to
> support HSM where data is migrated out to tape, and requires
> CAP_SYS_ADMIN.  Allowing it for any file owner would expand the scope
> for too much as now everyone could skip timestamp updates.

We have already provided a safe method for minimising the overhead
of c/mtime updates in the IO path - it's called lazytime.  The
lazytime mount option provides eventual consistency for c/mtime
updates for IO operations instead of immediate consistency.

Timestamps are still updated to have the correct values, but the
latency/performance of the timestamp updates is greatly improved by
holding them purely in memory until some other trigger forces them
to be persisted to disk.

> > It can be used by workloads that want to write a file but don't care
> > much about the preciese timestamp on it and can update it later with
> > utimens() call.
> 
> The workload might not care, the rest of the system does.  ctime can't
> bet set to arbitrary values, so it is important for backups and as
> an audit trail.

Lazytime works for this use case; a call to utimens() will cause a
persistent update of the timestamps. As will any other inode
modification that has persistence requirements (e.g.  block
allocation during IO or other syscalls that modify inode metadata).

> > There's another reason for having this patch. When performing AIO write,
> > the file_modified_flags() function checks whether or not to update inode
> > times. In case update is needed and iocb carries the RWF_NOWAIT flag,
> > the check return EINTR error that quickly propagates into cb completion
> > without doing any IO. This restriction effectively prevents doing AIO
> > writes with nowait flag, as file modifications really imply time update.
> 
> Well, we'll need to look into that, including maybe non-blockin
> timestamp updates.

This came up recently on #xfs w.r.t. lazytime behaviour - we need to
pass the NOWAIT decision semnatics down to the filesystem to allow
lazytime to be truly non-blocking.  At the moment the high level VFS
NOWAIT checks (via inode_needs_update_time()) have no visibility of
this filesystem specific functionality, so even if we can do the
lazy timestamp update without blocking we still give an -EAGAIN if
IOCB_NOWAIT is set.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

