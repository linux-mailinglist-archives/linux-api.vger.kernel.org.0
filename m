Return-Path: <linux-api+bounces-2634-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B24999B3DE2
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2024 23:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB841F23041
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E71EE031;
	Mon, 28 Oct 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="bLb3h18w"
X-Original-To: linux-api@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF618FDC2;
	Mon, 28 Oct 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155037; cv=none; b=QAGazQYNV5heWUM4/GHp5e1YrqQNdkfTW0Si7zJ2869Bb18g+GvJIVk5OT4VChOSd8X1CotfgZEFEz50KIb6uMYFeFTIpfVNG2ln8N6yX4bSWYLU8qDCc8sKHWeuog+NyBa0dRTLVFEF+xivI4Yk5ShhOhu1kbSfLxkoYAH2iAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155037; c=relaxed/simple;
	bh=txZ5FjWCswLrn5R55z+wYaLbR9OTGv+7YeGcXUxb8wU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ML+ezt6WKKAOL86rs8BCGhWYb5kbmlyKFE3U1cL+2tqZqTqAjhLtxxLZJh7qlpAdDaC5dUaL70H9CIFEcZaiMGDKDDoyep1mQYD8VCWUtykFuh21Y5KIk5JcWcNCs9CFq3mr/qbDQbgryVaqXnaSqtdBGU7KUtoSrEcHnH8KoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=bLb3h18w; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1730155035;
	bh=txZ5FjWCswLrn5R55z+wYaLbR9OTGv+7YeGcXUxb8wU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bLb3h18wgG+pWjMR3LBhLa5H3cOjWb4ZEVRL0zBy/sDAOIROkHifR2SEggXt+FZl9
	 IJ6DUCoQqHVdne3vCbwAt0YMT3brstrJrt/p0B9q+GH9jj3rhbTv5sbev7GL84AvkN
	 SrUNrq5CrpzNSxczBYaIuVFfdWcGptTYeYHizNVQ=
Received: by gentwo.org (Postfix, from userid 1003)
	id 3012340262; Mon, 28 Oct 2024 15:37:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2EFAE401C8;
	Mon, 28 Oct 2024 15:37:15 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:37:15 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com, 
    dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com, 
    Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com, 
    hch@infradead.org, lstoakes@gmail.com, Arnd Bergmann <arnd@arndb.de>, 
    linux-api@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
    malteskarupke@web.de, llong@redhat.com
Subject: Re: [PATCH 2/6] futex: Implement FUTEX2_NUMA
In-Reply-To: <20241028094618.GL9767@noisy.programming.kicks-ass.net>
Message-ID: <50dc2133-5f43-3a02-38a9-234e8acb5b8c@gentwo.org>
References: <20241025090347.244183920@infradead.org> <20241025093944.485691531@infradead.org> <dce4d83c-fb3f-3581-71e4-33dad3f91e07@gentwo.org> <20241028094618.GL9767@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Oct 2024, Peter Zijlstra wrote:

> Using get_task_policy() seems very dangerous to me. It is explicitly
> possible for different tasks in a process to have different policies,
> which means (private) futexes would fail to work correctly.
>
> We need something that is process wide consistent -- like the vma
> policies. Except at current, those are to expensive to readily access.

The vma policies are bound to addresses that in turn yields address space
wide validity.

However, different threads may run on processes on different nodes and
therefore having different numa nodes close to them etc.


