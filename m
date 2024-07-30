Return-Path: <linux-api+bounces-2045-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD8940548
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2024 04:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AF71C20D87
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2024 02:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9662A1D5;
	Tue, 30 Jul 2024 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="trIwHAzt"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B01FAA
	for <linux-api@vger.kernel.org>; Tue, 30 Jul 2024 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722306723; cv=none; b=PAGia8UkCMypAnPtRgC23FZbgp4XCyEfJVqzg9c7OUcUfNlzEt4c/486pNwKe4ap731TrYgAw9CBrv95VKv4pnsRojKmvdEFgK3NV4Zg+PBCKJqK/NiIWg7DqZkJZw18FmMEiIwGhhC/4Fnr/cVy/O4uOuHwblpl8cZ9LiQman8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722306723; c=relaxed/simple;
	bh=tOO86y8V3WUKAK5XBg1b8kaBvFUSchEmH0uCHmb3UAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNleY6RCvW8Iddu7IHxmSDLeLlfdG7zEavNz9MeGOf74oG2YsGd3lLR+wqw1O4AphU255b5SOvSkExxPqoMvijBCJ0Df6tK/xntPLTsOWJ79lkQWYOfAoqcdAHt+Odnifv032TZF7DmYK4kkCqFTkVZdGitHW8C1gC0SsGFOoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=trIwHAzt; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1553014a12.3
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2024 19:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722306721; x=1722911521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFhRc4/vYKzneuFn+DFlfYxVPf9CprdyrFUOhdCUb6Y=;
        b=trIwHAzt4vySh8AXYQ11iX8L2SvX7uQTy3rPxwDShEGmVFUgZWLzZOBiInnLWcaejs
         RA2GO3OaRUUhBfgnu0UquhpE/FQlBPwh2ou7HZNpD3S/zY4gY9ClrJe7K9BEUrisYOsW
         I7lyDilhCwVSrLV+uSBViePhFXdismWd9PFAHNONaZA8O1ckVfJoRDIK0bSb0CcHIbVY
         XLu43EuiitdLak7yn97a5qWe3jG/hVeBtY2Lmoec3vyPw5Pd8ERVaDKFq9UWrWZctAWE
         Bv3hWk5bQFlB2SRNu2KfmsCQuFyJUyn7GT+/XKzsY0G9vLCSOSW0PUaap4tAFc+yTlUJ
         wRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722306721; x=1722911521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFhRc4/vYKzneuFn+DFlfYxVPf9CprdyrFUOhdCUb6Y=;
        b=SYBqqBpHSaX2p76corUWO0Trs9FRRXSI/QcnGMwLhDUcEin5MH+/JQnftzR5vWGM7N
         f5FijqukT6NpB1YPmeXdAhRW3r0juUkXL1RvlSDeC+mjKkAj0m38to/l4Bq/j0qoOKnv
         Geiks0N/TwA66B0J1A8tglDNYSO2MwV3Wy5JBjFssicZZHaGdwJqr/h8uxma/NJmADqQ
         z+MB8h6vR6ISpwQX9szWjSoAK+Bg2WJvV23QqJMi3A1vjeZoVovJMY28Ksw5qlkLRYTm
         KuZuohUZtx1GvLKIoZWZSr0QUsuvhqSUivsoCKbi+C9bGqOD2mbsGzywM2uYh59dKWxJ
         uC3g==
X-Forwarded-Encrypted: i=1; AJvYcCUxxRf1DIC2ha9Nq1MOLoRHfvePrMDecgR0Rs6pqvHx74FRzp5919Vbg07CCXFa8dJtbxGqoLv1yKLBt6DGqFGcVwuGyNEaK6Ae
X-Gm-Message-State: AOJu0YwEIiGRlctUQTytNZIk2bm7Qhy1TkQ59Cl+EvJzkiUaueaKQqqd
	nkqUqlqjnqPUrG36ytgKxEFWDxuvPGsJtUz0kLXyWosPTdEOnHXy0LZQLWHbrHU=
X-Google-Smtp-Source: AGHT+IFtkp9YLxmPFjkciYZk1h4UD8NNOgy3iXel92zDfGVP4wFKLuT7Ekrw2+r413XgYa4i+aYUpg==
X-Received: by 2002:a05:6a20:7487:b0:1c4:8ddb:3fac with SMTP id adf61e73a8af0-1c4a12e0de9mr12920008637.23.1722306721120;
        Mon, 29 Jul 2024 19:32:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8122ddsm7471291b3a.133.2024.07.29.19.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 19:32:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sYceb-00GEgB-2b;
	Tue, 30 Jul 2024 12:31:57 +1000
Date: Tue, 30 Jul 2024 12:31:57 +1000
From: Dave Chinner <david@fromorbit.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Florian Weimer <fweimer@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <ZqhQnWQSweXgffdD@dread.disaster.area>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <20240729133601.GA557749@mit.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729133601.GA557749@mit.edu>

On Mon, Jul 29, 2024 at 09:36:01AM -0400, Theodore Ts'o wrote:
> On Mon, Jul 29, 2024 at 12:18:15PM +0200, Mateusz Guzik wrote:
> > 
> > Are you claiming on-disk inode numbers are not guaranteed unique per
> > filesystem? It sounds like utter breakage, with capital 'f'.
> 
> The reality is that there exists file systems which do not return
> unique inode numbers.  For example, there are virtiofs implementations
> which pass the inode numbers straight through with a fixed dev_t.  If
> you have a large number of packages mounted via iscsi, and those
> packages include shared libraries, then you can have two different
> shared libraries with the same inode number, and then you can watch
> the dynamic liunker get Very Confused, and debugging the problem can
> be.... interesting.  (Three gueses how I found out about this, and the
> first two don't count.  Yes, we figured out a workaround.)
> 
> So that breakage exists already, today.
> 
> For people who don't like this, they can stick to those file systems
> that still guarantee unique inode numbers, at least for local disk
> file systems --- for example, to use ext4 and xfs, over btrfs and
> bcachefs.

I don't think you can make such a simplistic delineation, because
there's more than one issue at play here.

There are at least two different "is this inode identical"
use cases that {st_dev,st_ino} is being used for.

The first, as Florian described, is to determine if two open fds
refer to the same inode for collision avoidance.

This works on traditional filesystems like ext4 and XFS, but isn't
reliable on filesystems with integrated snapshot/subvolume
functionality.

The second is that {dev,ino} is being used to disambiguate paths
that point to hardlinked inodes for the purposes of identifying
and optimising access and replication of shared (i.e. non-unique)
file data.

This works on traditional filesystems like ext4, but fails badly on
filesystem that support FICLONERANGE (XFS, btrfs, NFS, CIFS,
bcachefs, etc) because cloned files have unique inodes but
non-unique data.

> However, this is a short-term expedient, and in the long term, we will
> need to guide userspace to use something that is more likely to work,
> such as file handles.

The first case can be done with filehandles - it's a simple
resolution of fds to filehandles and compare the opaque filehandles.
That's the short-term solution because it's the easy one to solve.

However, filehandles do not work for the solving the second case.

Hardlinks are basically a mechanism for avoiding data copying within
the same filesystem.  i.e. hardlink disambiguation is essentially
the process of detecting which dirents point to the same shared
data. We can detect a hardlinked inode simply by looking at the
link count, and we use the inode number to determine that they point
to the same physical storage.

Applications like tar and rsync are detecting hard links to avoid
two main issues:

	- moving the same data multiple times
	- causing destination write amplification by storing the
	  same data in multiple places

They avoid these by creating a hardlink map of the directory
structure being processed, and then recreate that hardlink map at
the destination.  We could use filehandles for that, too, and then
we wouldn't be relying on {dev,ino} for this, either.

However, any application that is using inode number or filehandle
comparisons to detect data uniqueness does not work if other
applications and utilities are using reflink copies rather than
hardlinks for space efficient data copying.

Let's all keep this in mind here: the default behaviour of `cp` is
to use file clones on filesystems that support them over physical
data copies. I have maybe half a dozen hardlinks in most of my local
XFS filesystems, but I have many tens of thousands of cloned files
in those same filesystems.

IOWs, any tool that is using {dev,ino} as a proxy for data
uniqueness is fundamentally deficient on any filesystem that
supports file cloning. 

Given the potential for badness in replicating filesystems full of
cloned data, it's far more important and higher priority for such
utilities to move away from using {dev,ino} to detect data
uniqueness. Handling cloned data efficiently requires this, and
that's a far better reason for moving away from {dev,ino} based
disambiguation than "oh, it doesn't work on btrfs properly".

Detecting "is the data unique" is not that hard - e.g. we could
add a statx flag to say "this inode has shared data" - and then
userspace can tag that inode as needing data disambiguation before
starting to move data.

However, data disambiguation (i.e. finding what inodes share the
data at which file offset) is a much harder problem. This largely
requires knowledge of the entire layout of the filesystem, and so
it's really only a question the filesystem itself can resolve.

We already provide such an interface for XFS with ioctl(GETFSMAP).
It is driven by the on-disk reverse mapping btrees, and so can
quickly answer the "what {inode,offset,len} tuples share this
physical extent" question. The interface is generic, however, so
asking such a question and determining the answer is .... complex.

That is our long term challenge: replacing the use of {dev,ino} for
data uniqueness disambiguation. Making the identification of owners
of non-unique/shared data simple for applications to use and fast
for filesystems to resolve will be a challenge.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

