Return-Path: <linux-api+bounces-3150-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8D5A283AC
	for <lists+linux-api@lfdr.de>; Wed,  5 Feb 2025 06:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FDB1645F0
	for <lists+linux-api@lfdr.de>; Wed,  5 Feb 2025 05:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3AF21E082;
	Wed,  5 Feb 2025 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s64R07DK"
X-Original-To: linux-api@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F921D5A7
	for <linux-api@vger.kernel.org>; Wed,  5 Feb 2025 05:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733318; cv=none; b=AybVG1yGF936lUfZ+0FIibLDaC3sfrhcfelvOmiWfnKAQa5jBBjzjhIkFEyxTC7aIfKbF2L3/YqiIYiqpTa/+8SVw4sJXSxnWZm9TABBDYfqDjGcQF9kQQOsJLpdTALqDbJXhy1bgtE8CvSQX0MXJRwR5aHNeHxahbyiWeXHxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733318; c=relaxed/simple;
	bh=Go9zeeiOyklOxfrSqGZOTsXxnrPwaUTurqKvgFVPrCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs4/pcXkWs66xpJ3jV37xTil9TgNwefZH9rnmY157qyW3vGfYMfITyGcDfG1ztZ9TWSWWo75dWfQBsnLIgcfmzbUHTZ54WHy4C1z49yO5XZUFYaCAu0pxuvTjVIDYOBpkE1Tti9TkI9pp09v/yDiDnebpg+bXN0D6gTcpEJTX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s64R07DK; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 4 Feb 2025 21:28:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738733314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGYbLLqCxi5Wx9TMEZ9Netc4G9Rz9B9h/UjJRil5hPM=;
	b=s64R07DKg6d0bu4Ewy9zkH+YLZ03hzB92uhRXI5N3Bvqan9/gT0GOx+aMvNT9zykRPHusu
	e0RU87O38y4gQNTX+XHBg4PoVtooAjS0A0/48U4n+t7UcayOUoGCY30ELvUDLUaKOT23XA
	7Q0eMKpFRrXo82QxfR1cqxfdWaXu1S8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 6/6] selftests/mm: use PIDFD_SELF in guard pages test
Message-ID: <ee7mum3qudn2xuvf7r2g7loqjeiwyxj6icpnuvorlk7alatatr@vifaixknxlr3>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <69fbbe088d3424de9983e145228459cb05a8f13d.1738268370.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69fbbe088d3424de9983e145228459cb05a8f13d.1738268370.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 08:40:31PM +0000, Lorenzo Stoakes wrote:
> Now we have PIDFD_SELF available for process_madvise(), make use of it in
> the guard pages test.
> 
> This is both more convenient and asserts that PIDFD_SELF works as expected.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

