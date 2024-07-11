Return-Path: <linux-api+bounces-1951-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD8E92F020
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 22:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5413D1F25610
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A419E811;
	Thu, 11 Jul 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lgQNcIYt"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61718E20;
	Thu, 11 Jul 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728457; cv=none; b=AonPkOUaKw/TiaA2Xalt7PPy/IhbqWH4AUprgpZ+PpXHm2QyIvMIArocSGKYJ8qKM+ekk1kClf+5jqYBDJWH32Op4abVWWy/W6JsgVKqYaEbFEx40iSuiH5E3knvfERyEBh7lo4WChkGCAsToz+6x77GoUK1VSuexkPLvHQ4GoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728457; c=relaxed/simple;
	bh=EM/GUu+kJS5WyLavGs3+u7kMvso4te/aW/5UoAntXwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIJ5323jYkwT9TrcA/W8Xq1+9j3yPhKHZMLvNRPDeG9LijbMvGetT/ekQuAaYj6UrSwvgzZf4pxAYLxN649x2cM8TtkiHS3RLLszhz6yS4gaSL8D9cefvuNmx2+YMNO3Hq84fkfiGbFtX8ppAfwuUOF5MOQifbwOBgHE9oZ1ow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=lgQNcIYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72243C116B1;
	Thu, 11 Jul 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lgQNcIYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720728453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNdo2jHrY/IOSCFrJ93vxKtkJPtxtIos5+7ObgdaWQc=;
	b=lgQNcIYtqgWSPoe7Cx4AcSLb9J+QfSbCUixBhBJvYlxEE1Lzsyh6WkLBb6U/EWGhY0760F
	1SNYJbibFL67nsr+nkaJKo9u0ehTmV2CCIByy0wQFwW6RK6nqdnXn4dJNCeTU6WJVq8fcw
	m+k5ajRjjWlfcvMXDyCJC2EbqnJdNVo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a218a39f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 20:07:33 +0000 (UTC)
Date: Thu, 11 Jul 2024 22:07:30 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, tglx@linutronix.de,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZpA7gvIvxNRkd6hp@zx2c4.com>
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com>
 <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com>
 <CAHk-=whGE_w46zVk=7S0zOcWv4Dp3EYtuJtzU92ab3pSnnmpHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whGE_w46zVk=7S0zOcWv4Dp3EYtuJtzU92ab3pSnnmpHw@mail.gmail.com>

Hi Linus,

On Thu, Jul 11, 2024 at 10:57:17AM -0700, Linus Torvalds wrote:
> May I suggest a slightly different approach: do what we did for "pte_mkwrite()".
> 
> It needed the vma too, for not too dissimilar reasons: special dirty
> bit handling for the shadow stack. See

Thanks for the suggestion. That seems pretty clean.

It still needs to avoid setting swapbacked in the first place, but
ensuring that it's never dirty means it won't get turned back on.

The first patch renames pte_dirty() to pte_dirty_novma(). The second
patch adds an inline function, pte_dirty(pte, vma) that just forwards
the pte to pte_dirty_novma(), and then converts callers that have a vma
available to pass to call pte_dirty(). And then the VM_DROPPABLE patch
simply adds the `&& !(vma->vm_flags & VM_DROPPABLE)` condition to
pte_dirty().

I put these in https://git.zx2c4.com/linux-rng/log/ per usual, and I'll
post a new version to the list not before long (unless objections).

Jason

