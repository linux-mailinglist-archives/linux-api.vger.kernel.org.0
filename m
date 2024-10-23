Return-Path: <linux-api+bounces-2527-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFAB9ABA77
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2024 02:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFAD28317A
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2024 00:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A4171BB;
	Wed, 23 Oct 2024 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u1yRxgri"
X-Original-To: linux-api@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BC125D5
	for <linux-api@vger.kernel.org>; Wed, 23 Oct 2024 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642817; cv=none; b=uOGQjkHcmmjF1uiZdbehYQlMZGfXZZd8YQL+qoQGspa3jUGsG4Zcvi0WCwEsQL2q+vViTzWHSeSdfo+EPkEVEO/3fqtSrsoKZUfFF8S5/+kPNovr1w7inIpeOYpQ48did3N1UkzJjhG9cz26A+d+cB26yBAeg4H9Jl1NBvvDVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642817; c=relaxed/simple;
	bh=1kLBdFE+anbsM2Mi24KQGhJ/hy8EXtp5WfgCyCsjvVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buZFKsWV1dZPKi7KMPvbf+oHezKVkWO0fAjjEirhf7IV3MUsXmQaVDBOwfT54wC38zhUhXNrsMvWiA4MeyykHdGmhr8UmB6CgoFRBgPVU9WBHpAxyxp0Qhvjlv7J1PjtDXHzK0hX7e6tdjZ5GVl9Pa/S1OQtih7INXutMqUw4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u1yRxgri; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 17:20:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729642813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z15RmE1aCX+3NKMPTr3rVyCAh7IDX7aly0QhzhKsF5w=;
	b=u1yRxgriHqCN56anBMBUPKzkxEOyKHZ5NvPRH/5iwxiEhTLfXkbqCDSfH3mkjPDisedQVT
	rdhSxs1VD/+HtNoN50VVmePoWHVd+9I1TnFs6gBtpS4WWtgzurycAokRmSQG9kI0N6CftM
	oN7GbRS74vEbNxIk045YhYXWowvWO1I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 1/4] pidfd: extend pidfd_get_pid() and de-duplicate
 pid lookup
Message-ID: <qruy775a4vayqstswwaqxpqtp7mcckqa3tme64buzjts4zrmm7@la47lojzelhj>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <94a3210afe96c9d1d6f9460d7d37a43e5bc5f550.1729198898.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94a3210afe96c9d1d6f9460d7d37a43e5bc5f550.1729198898.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 17, 2024 at 10:05:49PM GMT, Lorenzo Stoakes wrote:
> The means by which a pid is determined from a pidfd is duplicated, with
> some callers holding a reference to the (pid)fd, and others explicitly
> pinning the pid.
> 
> Introduce __pidfd_get_pid() which narrows this to one approach of pinning
> the pid, with an optional output parameters for file->f_flags to avoid the
> need to hold onto a file to retrieve this.
> 
> Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
> directory, utilised by the pidfd_send_signal() system call, providing a
> pidfd_get_pid_proc() helper function to do so.
> 
> Doing this allows us to eliminate open-coded pidfd pid lookup and to
> consistently handle this in one place.
> 
> This lays the groundwork for a subsequent patch which adds a new sentinel
> pidfd to explicitly reference the current process (i.e. thread group
> leader) without the need for a pidfd.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

