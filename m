Return-Path: <linux-api+bounces-2939-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363489F57D0
	for <lists+linux-api@lfdr.de>; Tue, 17 Dec 2024 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046731887457
	for <lists+linux-api@lfdr.de>; Tue, 17 Dec 2024 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACFA1F8929;
	Tue, 17 Dec 2024 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qGvfourp"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4415DBBA;
	Tue, 17 Dec 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467512; cv=none; b=iPEsycmSRbrqB9I5Y6CHGk6rS+DnoQ1CQM4Ov50hNvrfdnjgKTS4aiJpEJvlzTA+ppytLXRixFdWWUE8+bRFTRcDzRww4s6H+25HgIFTsGvq1aLPXYAPS3a02rm3Po/CbQ9sR0D3g35ImU3mDj7wdmPMLviPSUbbXU4JE/JD5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467512; c=relaxed/simple;
	bh=F35cSH8lzmfU48CK6C1xYC+KTBU/f00fTD2zySlVK0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WShqSbYuDZjJs1ug6UWHjy768TgKezVR4tFItCPO0SkIrPoa4dg8qFiefp62rBLJjyjChyVySY3megO7YXk/oQaepw0diyPkFH2kD41bJ//aGslome6s4Kq5z/0Lod2d33hYB13S+TJJdQdTEgora06V9r5LBt9iJaHo80xNQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qGvfourp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=F35cSH8lzmfU48CK6C1xYC+KTBU/f00fTD2zySlVK0c=; b=qGvfourp3VZFsraJAFvqmbCRqy
	6a5Gx1YODVaY3csQ9iQnbkO7W29mpXhGCgtjIU0PeWeAhpEVB4JVR3ec9cJO3dTU0M+wvh6KvaDtw
	SDcF7u9x17sDYva+Alke48Nv5Jfrup/uTNi6GfDsUu6FeZg4HevHs57eFGDFZFKBDwcjrQmrpWVSM
	AgwoQAzzFURGq/qSADdp1oJB5HBhBn7co7RM7sdHSEnXgkmYI6eIQmTKUMVXZnYo/Z6az3BqEo0kX
	4wObHeoWESEmbwztl1zmoVZnyxqW2NAiG/xH6MIobYqs690IE43jJNLihCcV0E/rEwKs7Qgd5NBJ8
	WzKymmLw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeEH-00000009K8N-3ci9;
	Tue, 17 Dec 2024 20:31:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D8D5E3003E1; Tue, 17 Dec 2024 21:31:40 +0100 (CET)
Date: Tue, 17 Dec 2024 21:31:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, linux-api@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Vinicius Peixoto <vpeixoto@lkcamp.dev>
Subject: Re: [PATCH v3 0/3] futex: Create set_robust_list2
Message-ID: <20241217203140.GH11133@noisy.programming.kicks-ass.net>
References: <20241217174958.477692-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217174958.477692-1-andrealmeid@igalia.com>

On Tue, Dec 17, 2024 at 02:49:55PM -0300, André Almeida wrote:
> This patch adds a new robust_list() syscall. The current syscall
> can't be expanded to cover the following use case, so a new one is
> needed. This new syscall allows users to set multiple robust lists per
> process and to have either 32bit or 64bit pointers in the list.

Last time a whole list of short comings of the current robust scheme
were laid bare. I feel we should address all that if we're going to
create a new scheme.


