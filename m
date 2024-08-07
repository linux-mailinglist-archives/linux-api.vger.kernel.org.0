Return-Path: <linux-api+bounces-2145-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A421E94A7AA
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2024 14:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BEECB20FBC
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2024 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7176E1E4F13;
	Wed,  7 Aug 2024 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YnW/rQyo"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C91E4F01;
	Wed,  7 Aug 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033598; cv=none; b=ex7fMOY0h1+qmsqp8VnojAl3ce/6Tb/BfK6PNwkhMEKQlMmM1ZEOBCUR0IXLo7bXhtadCw7Dr25UFI7cdy/x71QifFhElSMIp0mg5zPIbeU+f41LVUo/q9MJ9B6um9m+fzlcxbk7oJ9O7kRmyJGTWuKUCiud+IJH/pFRGZMNRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033598; c=relaxed/simple;
	bh=OdSt8Tt/U2n9w379ApL8F4qbwce1h8QlEm0Nmuegrok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WJcked0XNzt/QRff44cAjhFz8XoBV37tjZDaV2s9Dgo089JaJW6cGeX1IdVp2MbWohljoaFbNqoHMf8B0jIEbZoU/RPVsNPMXEGETZxaGYj9vtucBNqUIPlKUZDuK25Bxry6QiD60NgKzDQ50y1nyUvRXvgmDhHKHgNEXcYDCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=YnW/rQyo; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723033593;
	bh=OdSt8Tt/U2n9w379ApL8F4qbwce1h8QlEm0Nmuegrok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YnW/rQyoOAweXydm9V9Sx4BR5bWp3A63VMYTQOpI6d+m0m2ffd7dxUELQRLPFMqm/
	 Mw6qICJkyvvkG/kmwzJnV4GB9zVM3iI8pmVrycRYA4D5KJJGgDH3NkZTBwdsS3E/kj
	 EQiAekjjIpIrbD/h1ce2NPPaFtT66mIGyfR7UT+GZCUtZGI59/LL+0d7e1IF0s+5Sy
	 sAwNOzdXEoDeUrH2fZa6bVmu4nVUajRSs9G8pgOr8IdBQW+rdINjVU1j5SF8xKI77g
	 yuxwSVbW0ttpngBkzDHghMP153gkq3dmrCWyqqUyzSIrD7jLrKRbU+EKonFk5XQi0x
	 WDAy6902F5RPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wf8YL6FV0z4w2Q;
	Wed,  7 Aug 2024 22:26:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Xu <jeffxu@google.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato
 <pedro.falcato@gmail.com>, kernel test robot <oliver.sang@intel.com>, Jeff
 Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck
 <groeck@chromium.org>, Jann Horn <jannh@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew
 Wilcox <willy@infradead.org>, Muhammad Usama Anjum
 <usama.anjum@collabora.com>, Stephen =?utf-8?Q?R=C3=B6ttger?=
 <sroettger@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Amer Al Shanawany
 <amer.shanawany@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mseal] 8be7258aad:
 stress-ng.pagemove.page_remaps_per_sec -4.4% regression
In-Reply-To: <CAHk-=whQ4x+ZgG7txteY70fvmHkuvRstMZj06XscmKfDL+RBCg@mail.gmail.com>
References: <202408041602.caa0372-oliver.sang@intel.com>
 <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
 <87o766iehy.fsf@mail.lhotse>
 <CAHk-=whQwJaS=jVWVvvvf0R=45EGMb0itmhhSpa7_xWJXQY71Q@mail.gmail.com>
 <87bk25j1sx.fsf@mail.lhotse>
 <CAHk-=whQ4x+ZgG7txteY70fvmHkuvRstMZj06XscmKfDL+RBCg@mail.gmail.com>
Date: Wed, 07 Aug 2024 22:26:29 +1000
Message-ID: <87v80c8qoa.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Tue, 6 Aug 2024 at 05:03, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Or should I turn it into a series and post it?
>
> I think post it as a single working patch rather than as a series that
> breaks things and then fixes it.

It splits nicely with no breakage along the way.

> And considering that you did all the testing and found the problems,
> just take ownership of it and make it a "Suggested-by: Linus" or
> something.

Sure.

cheers

