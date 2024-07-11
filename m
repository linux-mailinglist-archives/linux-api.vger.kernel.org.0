Return-Path: <linux-api+bounces-1936-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1472292EE21
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815D6B21786
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD0816CD18;
	Thu, 11 Jul 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fVHtpJqe"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2B6EB7C;
	Thu, 11 Jul 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720606; cv=none; b=ZdjdGCOOp4pl3JDM9sAvAkP3fdAnRml1mqAd2VlAYue39ccGD1+0Hm1iEC431m/jWmJLrzZTzfeA8Wv1y1+hRv1t+EPfndCzHRvRilr8qaE8C4ZPGc/BzFmbTlE+G2wWbq3eliYSGMtSDUhTBMlMC3JOFvd34UsPIYnklkxeGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720606; c=relaxed/simple;
	bh=KC4Aqvaj9YS7FLQ2k7vVBoNsfK+yoQgbJnWrYEEdAME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIb1abQKW9hkrRiZEweATTOj+Ci0F6Pp8+NegV22F6M6R0Gbb0bQn4QNUO20VmHic8TckGmJ80YpuOWDbetgFm7C4ZNrGqclOfQFQt7gh840sNzXYONkYLKhuRZBOs+28ZlQNfJLAiZnB3ovb3r5kKkIHE4eMZAjUpTZQ4sa8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=fVHtpJqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2B2C116B1;
	Thu, 11 Jul 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fVHtpJqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720720602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6aFx91QB3WDYeLKQAPStVNJmakgeBHZuSQXrzicavA=;
	b=fVHtpJqeifla+MPOLAe6cO6hPYuyBiNkqiLe9bl6wuFV7EytGPOqq5AHt93i5Rxo6Lm9ZS
	Rmtd6DX+Xtmx34a36oJfGPhFMl1T0nfg/C3a1HScZCnlZExs2BKhcY2DbPMfwM20ha+/Fe
	VNNaxIG3oSWj8iUKqasRbZvdsq+KbQA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c555226b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 17:56:42 +0000 (UTC)
Date: Thu, 11 Jul 2024 19:56:39 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZpAc118_U7p3u2gZ@zx2c4.com>
References: <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com>
 <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com>
 <ZpATx21F_01SBRnO@zx2c4.com>
 <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
 <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>
 <ZpAcWvij59AzUD9u@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZpAcWvij59AzUD9u@zx2c4.com>

On Thu, Jul 11, 2024 at 07:54:34PM +0200, Jason A. Donenfeld wrote:
> On Thu, Jul 11, 2024 at 07:27:27PM +0200, David Hildenbrand wrote:
> > > PG_owner_priv_1 maps to PG_swapcache? :)
> > 
> > Maybe the combination !swapbacked && swapcache could be used to indicate 
> > such folios. (we will never set swapbacked)
> > 
> > But likely we have to be a bit careful here. We don't want 
> > folio_test_swapcache() to return for folios that ... are not in the 
> > swapcache.
> 
> I was thinking that too, but I'm afraid it's going to be another
> whack-a-mole nightmare. Even for things like task_mmu in procfs that
> show stats, that's going to be wonky.
> 
> Any other flags we can overload that aren't going to be already used in
> our case?

PG_error / folio_set_error seems unused in the non-IO case.

