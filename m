Return-Path: <linux-api+bounces-1926-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B691292DF1F
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 06:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4587A2840D6
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 04:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6247B249FF;
	Thu, 11 Jul 2024 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hK6/BNkb"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0320664D;
	Thu, 11 Jul 2024 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720672355; cv=none; b=hVWrwOolUBGcXfOZOY44UrkuELWqWDQ/PyGlvXk6sPQHG+XFTHUW0aqdNs1JXZU2WhReO55/HYMaV6hpQqnrikiKruj/lca71FTGUn8wg6lvR12n/iaLRJ/6+qkXOjFfk7nfkV5WmCiHTdc3DmgEB284KEi5z+DnxeqPbREDreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720672355; c=relaxed/simple;
	bh=PgQXgRM6be8Wrz5n3qFnroBhMTZ8tyBF9PgE2xsLWXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeIfPWdl6gB7p39roJ3OYRZkyNwVcv25XnR0BWAfy4LxOhEtB8biJoR/ywCsnmbHTAg5Tv3eTtdZasS60OORKOTM1v5UTvEbJrtSnu2QuyCgUAmoERc6ipSaRnEE4OcIAGFGpIHvsSDLa750f4Fgw5iNNiN73ebkZs3Qgu0YI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hK6/BNkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC670C116B1;
	Thu, 11 Jul 2024 04:32:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hK6/BNkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720672351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bUM3Y4D20BWlPnBgrUFDE9T3dbKAyxe2+cRLVwadkjE=;
	b=hK6/BNkbjum1DdKhPbNaqS+k6MZP/K0HHkkVrVh2FOZaI9BTUGc8N9R3fJyjk1bY3L3/oQ
	mBJ2DOBMKD1ZCZLey6e8H38+z4FWQ+CowlExwdglfmBzvOHeWg7GWEG1CiJcyFv+hFueg1
	J7XZBZBxrAykIOV8BoMokWlCcLtv3w0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 36f7f89a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 04:32:30 +0000 (UTC)
Date: Thu, 11 Jul 2024 06:32:28 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Zo9gXAlF-82_EYX1@zx2c4.com>
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zo8q7ePlOearG481@zx2c4.com>

On Thu, Jul 11, 2024 at 02:44:29AM +0200, Jason A. Donenfeld wrote:
> Hi David,
> 
> On Wed, Jul 10, 2024 at 06:05:34AM +0200, David Hildenbrand wrote:
> > BTW, do we have to handle the folio_set_swapbacked() in sort_folio() as well?
> > 
> > 
> > 	/* dirty lazyfree */
> > 	if (type == LRU_GEN_FILE && folio_test_anon(folio) && folio_test_dirty(folio)) {
> > 		success = lru_gen_del_folio(lruvec, folio, true);
> > 		VM_WARN_ON_ONCE_FOLIO(!success, folio);
> > 		folio_set_swapbacked(folio);
> > 		lruvec_add_folio_tail(lruvec, folio);
> > 		return true;
> > 	}
> > 
> > Maybe more difficult because we don't have a VMA here ... hmm
> > 
> > IIUC, we have to make sure that no folio_set_swapbacked() would ever get
> > performed on these folios, correct?
> 
> Hmmm, I'm trying to figure out what to do here, and if we have to do
> something. All three conditions in that if statement will be true for a
> folio in a droppable mapping. That's supposed to match MADV_FREE
> mappings.
> 
> What is the context of this, though? It's scanning pages for good ones
> to evict into swap, right? So if it encounters one that's an MADV_FREE
> page, it actually just wants to delete it, rather than sending it to
> swap. So it looks like it does just that, and then sets the swapbacked
> bit back to true, in case the folio is used for something differnet
> later?
> 
> If that's correct, then I don't think we need to do anything for this
> one.
> 
> If that's not correct, then we'll need to propagate the droppableness
> to the folio level. But hopefully we don't need to do that.

Looks like that's not correct. This is for pages that have been dirtied
since calling MADV_FREE. So, hm.

