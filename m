Return-Path: <linux-api+bounces-1935-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0D492EE16
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB6D1F22204
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 17:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189A15B10A;
	Thu, 11 Jul 2024 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bX272hdY"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51086EB7C;
	Thu, 11 Jul 2024 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720480; cv=none; b=YaQ178a6qtCp4ufnVOqzpXWUfCJhjXgFgCp5fBXORY0KknOxu3GOfBXlGh5emjmOnnkUBVuNFaPfXNrTZWPjBzOO9g8ZaQT4/4XJ6qtaSHpXnYrq8EwII0bvz4Zxl+tK50uixGM226SyocMFjRk3w8agEt0uY9MgAkq4yi4c5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720480; c=relaxed/simple;
	bh=XJRaKmvbKp4vzurNcCaBn8DZgXO4iW+cUfjAZtaTREY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHa2U3rT7gkr7NvcVQsoh8k7vUdoLAgX8WRwV4PNrdydS8x7aYrISE4G3kjT2Z0qho0YskQWw5HYoSH9yhn+3MnlWEpr4/d7rbrBF1XJf8G4BjFw5NVJcXKiAsdoRJsO1+8Qt5Oo3JXx+E+eeHbCYWrnbLYrhsOjZ2mTXOWvVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bX272hdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C9CC116B1;
	Thu, 11 Jul 2024 17:54:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bX272hdY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720720477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GVAQ5L+3/5OC97I04hBIrirrfXPPBSu00RMxrqap2ZA=;
	b=bX272hdYsrXqThtfMnSOXp0QImYeQbkJJMIm5NMp9j4TF+fpU5ESUh7yC6ozSS8EYbuxja
	U7gJJqzV567amguOsMiSNxodeHoVwydTi+Zpuq/yk/G9Z0H80Mx0afU/NymIAf5Jfuoscc
	Rvp5KE15A6BowQIPH8A3rBQ3xb4Oo5A=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8bfe4072 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 17:54:36 +0000 (UTC)
Date: Thu, 11 Jul 2024 19:54:34 +0200
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
Message-ID: <ZpAcWvij59AzUD9u@zx2c4.com>
References: <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com>
 <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com>
 <ZpATx21F_01SBRnO@zx2c4.com>
 <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
 <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>

On Thu, Jul 11, 2024 at 07:27:27PM +0200, David Hildenbrand wrote:
> > PG_owner_priv_1 maps to PG_swapcache? :)
> 
> Maybe the combination !swapbacked && swapcache could be used to indicate 
> such folios. (we will never set swapbacked)
> 
> But likely we have to be a bit careful here. We don't want 
> folio_test_swapcache() to return for folios that ... are not in the 
> swapcache.

I was thinking that too, but I'm afraid it's going to be another
whack-a-mole nightmare. Even for things like task_mmu in procfs that
show stats, that's going to be wonky.

Any other flags we can overload that aren't going to be already used in
our case?

Jason

