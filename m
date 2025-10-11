Return-Path: <linux-api+bounces-5096-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E7EBCEDF8
	for <lists+linux-api@lfdr.de>; Sat, 11 Oct 2025 03:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA51A6698B
	for <lists+linux-api@lfdr.de>; Sat, 11 Oct 2025 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48C641A8F;
	Sat, 11 Oct 2025 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NuwnfwSi"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46542B9A8
	for <linux-api@vger.kernel.org>; Sat, 11 Oct 2025 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760146526; cv=none; b=hWbyei/4SwrVV6/2WCmkBQn6fvG1mHG+Ok/Qhavu2FDtHPidW4bHVtSCGNqt8P6MXtd4FK6unELAI8wANqEfM5IbDIJtoNvUuvgOoHlwYggkUdKTWqI//p7Oas/ddky37xkQr8uWMGqaeWeh1fOAB0sNhYv/dXk2I/U21UmNhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760146526; c=relaxed/simple;
	bh=xR0IE0cavrFuHS+sWvEAb/mnV0iT2JipQXIDw9PxCmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beLJLiGSafp4Q/2p7ZlpTcPoTbEAiSCievcPJ9ta3r3m/8s+c5NmzqQ22/TzzLx1kIttGk6IkaOyPW1kGnLDVYR3H6KxE4VANeEGuvTjHRQnZG7OLJUGmkQwCYMEn69zAeHnSTGUrNZXPuZFNzbdnl/OFs5Uwi+V+esd0oOnQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NuwnfwSi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7811fa91774so2327988b3a.0
        for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 18:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760146524; x=1760751324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XvBfLEx++WE1Un1u5T1nsAJnVIwWMs7QzpD2aMmgPU8=;
        b=NuwnfwSior1Z8jfrkAegV7FJKah7cY6lTZlyqFY057aw/K3HK+X+TK4NPPNYQAdGbS
         xQBM+Sq+LK4hMS2GKxmKc4X07PPlRprITGaThcvUhsmiou7eqL52ip9ciBx3W2h3GHy5
         5VC1Ug284Y3yHE7ehfHS+UfODeXb4wPjl4MjD+M6iEU8rlpYjJtm3dYmAGKEFtp+f+mP
         +HJ6qS1rRaDSRArxm6Vo3Cog7DrWm+dUpPefXsYBuEskw+KKAw7esFh6DOHAdDbIeCcn
         ebx8P9VwLU/SU1Qik5ZRjl7p3HYcSwYMpw82tFitsKjHgYG7PNYyy0OPKOh+zjxEoho0
         GSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760146524; x=1760751324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvBfLEx++WE1Un1u5T1nsAJnVIwWMs7QzpD2aMmgPU8=;
        b=iydfXa2rAZNwvXcYPWzNJe8iwvurvMtS7xxFVnlBplnstBwzs0dJ3irHIPF7e7JCly
         MiwaZ9Cn8qJfQhB2Zanvd2KieOP9pzJneePVRH4T+6SmvWP5KPtfxAFgeAsiLo6jFELh
         f2c/p3uR1WYhVhRFmn9qIbVsaM3A4WPIWfAFPzmS/CwlKmGlpTJ4GsHxxyGbp9e0fHsj
         mzIBuA0RoLy3u6/x6n3VWsODXd8mpiBX+nK6bLPjHTsNJLiPzPw5S9447Bc9rmgkk9jJ
         6V0rIncwJ+QZFj62dzVah5YNvJckktRnw1hPS/jShtW4q/pVWXtgd6jMAdKmSfIwqv2R
         5/lg==
X-Forwarded-Encrypted: i=1; AJvYcCWNPMjx277KXDAHVHzQoIiA7lVMSh54Uhfn9FweoFIqFiCXgNb4ofO3vG6I+Qi9sVfJ7n/1wq0VrkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7iZXoFhMnxgmuk6P9rgE1N30PIohUXp54oIy5Emx/BC9xmxm
	h+1hx4PoeM4TAD6UtPeS7lPQ/NDpnoJiSnu+6EIre+yezOpnhoBOGa/QPtVplatErRU=
X-Gm-Gg: ASbGncvLGhqX9xW0yw5AWuvCDPusciTu9bqkqBMg27A/2/TNIQ3F78vJ6enYrQ7RjNg
	2vqeLbesQbqaRd1FKg6AWJSn3QM4W4cMGLHIZMr6d7BGfty7k+Q1wfI+uainXOx+5vlsh6T+kyM
	wFDH4xyeYkarQe2yZoWQZPN9EUAWye0DLOOGI8auvmpJ7Mms+mQp8335MEHop2Jxv5lGb9zRgyJ
	CT+ChRoHpxbdEK91RI2fuOJvfNeRo9lYfZ2yHj4qM5gijIQW2/AJORrKydm9S9rBMecPVWuRset
	DpnthDFH5U8+Z1NYIKRpCX5rXw68tiWcoVCFZXbXi3mwZxry+Wt9JarU8e/pAsRaA5x9nh7nbIk
	4ijAo5oR1+1W/d3lQlzqUq0HK79YfiPUDoabnVgG0CQl6vrxWj+f4S9dmJDLlyDU2VoxYg+qBxz
	DHWrxUel5O05rCZLXN
X-Google-Smtp-Source: AGHT+IEniEi9MIGgRunuUrN+JFg+dx6vAM1Vi/J7MDf0PCiszN+aXqLXt9e6v1B48WCt7nSz67SjpA==
X-Received: by 2002:a05:6a00:3c8e:b0:781:17fb:d3d0 with SMTP id d2e1a72fcca58-79385ce7d83mr17895097b3a.8.1760146523720;
        Fri, 10 Oct 2025 18:35:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b733abdsm4353443b3a.25.2025.10.10.18.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 18:35:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v7OW0-0000000DEDr-1EsT;
	Sat, 11 Oct 2025 12:35:20 +1100
Date: Sat, 11 Oct 2025 12:35:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org,
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing
 O_NOCMTIME
Message-ID: <aOm0WCB_woFgnv0v@dread.disaster.area>
References: <20251003093213.52624-1-xemul@scylladb.com>
 <aOCiCkFUOBWV_1yY@infradead.org>
 <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com>
 <aOSgXXzvuq5YDj7q@infradead.org>
 <CALCETrW3iQWQTdMbB52R4=GztfuFYvN_8p52H1fopdS8uExQWg@mail.gmail.com>
 <aObXUBCtp4p83QzS@dread.disaster.area>
 <CALCETrX-cs5MH3k369q2Fk5Q-pYQfEV6CW3va-4E9vD1CoCaGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrX-cs5MH3k369q2Fk5Q-pYQfEV6CW3va-4E9vD1CoCaGA@mail.gmail.com>

On Wed, Oct 08, 2025 at 02:51:14PM -0700, Andy Lutomirski wrote:
> On Wed, Oct 8, 2025 at 2:27 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Oct 08, 2025 at 08:22:35AM -0700, Andy Lutomirski wrote:
> > > On Mon, Oct 6, 2025 at 10:08 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Sat, Oct 04, 2025 at 09:08:05AM -0700, Andy Lutomirski wrote:
> 
> >
> > You are conflating "synchronous update" with "blocking".
> >
> > Avoiding the need for synchronous timestamp updates is exactly what
> > the lazytime mount option provides. i.e. lazytime degrades immediate
> > consistency requirements to eventual consistency similar to how the
> > default relatime behaviour defers atime updates for eventual
> > writeback.
> >
> > IOWs, we've already largely addressed the synchronous c/mtime update
> > problem but what we haven't done is made timestamp updates
> > fully support non-blocking caller semantics. That's a separate
> > problem...
> 
> I'm probably missing something, but is this really different?

Yes, and yes.

> Either the mtime update can block or it can't block.

Sure, but that's not the issue we have to deal with.

In many filesystems and fs operations, we have to know if an
operation is going to block -before- we start the operation. e.g.
transactional changes cannot be rolled back once we've started the
modification if they need to block to make progress (e.g. read in
on-disk metadata).

This foresight, in many cases, is -unknowable-. Even though the
operation /likely/ won't block, we cannot *guarantee* ahead of time
that any given instance of the operation will /not/ block.  Hence
the reliable non-blocking operation that users are asking for is not
possible with unknowable implementation characteristics like this.

IOWs, a timestamp update implementation can be synchronous and
reliably non-blocking if it always knows when blocking will occur
and can return -EAGAIN instead of blocking to complete the
operation.

If it can't know when/if blocking will occur, then lazytime allows
us to defer the (potentially) blocking update operation to another
context that can block. Queuing for async processing can easily be
made non-blocking, and __mark_inode_dirty(I_DIRTY_TIME) does this
for us.

So, yeah, it should be pretty obvious at this point that non-blocking
implementation is completely independent of whether the operation is
performed synchronously or asynchronously. It's easier to make async
operations non-blocking, but that doesn't mean "non_blocking" and
"asynchronous execution" are interchangable terms or behaviours.

> I haven't dug all the
> way into exactly what happens in __mark_inode_dirty(), but there is a
> lot going on in there even in the I_DIRTY_TIME path.

It's pretty simple, really.  __mark_inode_dirty(I_DIRTY_TIME) is
non-blocking and queues the inode on the wb->i_dirty_time queue
for later processing.

> And Pavel is
> saying that AIO and mtime updates don't play along well.

Again: this is exactly why lazytime was added to XFS *ten years
ago*. From 2015 (issue #3):

https://lore.kernel.org/linux-xfs/CAD-J=zZh1dtJsfrW_Gwxjg+qvkZMu7ED-QOXrMMO6B-G0HY2-A@mail.gmail.com/

(Oh, look, a discussion that starts from a user suggestion of
exposing FMODE_NOCMTIME to userspace apps! Sound familiar?)

> > IOWs, with lazytime, writeback already persists timestamp updates
> > when appropriate for best performance.
> 
> I'm probably doing a bad job explaining myself.

No, I think both Christoph and I both understand exactly what you
are trying to describe.

It seems to me that haven't yet understood that lazytime already
does exactly what you are asking for. Hence you think we don't
understand the "lazytime" concept you are proposing and keep trying
to reinvent lazytime to convince us that we need "lazytime"
functionalitying in the kernel...

> > > Thinking out loud, to handle both write_iter and mmap, there might
> > > need to be two bits: one saying "the timestamp needs to be updated"
> > > and another saying "the timestamp has been updated in the in-memory
> > > inode, but the inode hasn't been dirtied yet".
> >
> > The flag that implements the latter is called I_DIRTY_TIME. We have
> > not implemented the former as that's a userspace visible change of
> > behaviour.
> 
> Maybe that change should be done?  Or not -- it wouldn't be terribly
> hard to have a pair of atomic timestamps in struct inode indicating
> what timestamps we want to write the next time we get around to it.

See, you just reinvented the lazytime mechanism. Again. :/

-Dave.
-- 
Dave Chinner
david@fromorbit.com

