Return-Path: <linux-api+bounces-2664-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5DC9BB344
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 12:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7F11C21D20
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4896E1B3957;
	Mon,  4 Nov 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QfputQou"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051891AF0AD;
	Mon,  4 Nov 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719379; cv=none; b=qAjwP0qlaOQgPJeupTWZXhQ4qcmSoc55MmafkZ5I1wTSao836V2QyVnDUOLYcs79/FZzqVtS92JoAiy9BLCb2tO8QyQHicGsf5P5nteYmK6hRL6n6avHJTLkBqMaLRg3pfLQRhWnNChuVl+V8rHnAxnkXRiVvZbzdzMvQZgwDU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719379; c=relaxed/simple;
	bh=GmX+5ReYRGKyOBA5e9XwPfoI/zge5PTe+5H/WBxeO18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyMo5lFKrcLjVt4w50xyrO/+28/I2Eu7Evqiv51P5RyE5qT4jMG/dD3wRL1MNh9X96IouTlczSTkF+ubeOj81ND3szQVp+Q/WDqwh/KXG1qrS7R+WOy7ctEy7L9EYVXm5arKbl38iHAltYx6eobS4JWWxhzeaqDShORFqJH2WlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QfputQou; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kStgQ9judXPp6iv7CcnGttT9gMpvMgwVORafr+Lvw10=; b=QfputQousl5BEIbrjt5TLYF+Ui
	9F1scscmDhUpVOtwSTRwz4OhmP7LLhpJ3+gor7O665516JY1+wJSE5KIRBJbKB6MDgFeefRTu1X6K
	DeM+TvJWxlHBb/IXsaiq2YxZG3SpqBrueQ/tfIzySxnbpE2yxG8pUhzvSaAvNtDYMeyhSMiHCevl2
	6rz3wi9krsykMOiGHAvyT6D4cb3WaIJZfJ2lTFlRVoPFURFzQ9+4draF0wD0Jz4XL4h5/Sg9TKFRN
	Dc/kql4/7nw+W5PyzelXPXapMyQandrJu6UOg0C4r2hPybSNGH2tJHpFOuPXLJzG/BWQrXwAVhP/B
	ysD3z7xQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7vAP-000000016mv-1YHh;
	Mon, 04 Nov 2024 11:22:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CAC193006AB; Mon,  4 Nov 2024 12:22:40 +0100 (CET)
Date: Mon, 4 Nov 2024 12:22:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, linux-api@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 2/3] futex: Create set_robust_list2
Message-ID: <20241104112240.GA24862@noisy.programming.kicks-ass.net>
References: <20241101162147.284993-1-andrealmeid@igalia.com>
 <20241101162147.284993-3-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101162147.284993-3-andrealmeid@igalia.com>

On Fri, Nov 01, 2024 at 01:21:46PM -0300, André Almeida wrote:
> @@ -1046,24 +1095,44 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
>  
>  static void futex_cleanup(struct task_struct *tsk)
>  {
> +	struct robust_list2_entry *curr, *n;
> +	struct list_head *list2 = &tsk->robust_list2;
> +
>  #ifdef CONFIG_64BIT
>  	if (unlikely(tsk->robust_list)) {
> -		exit_robust_list64(tsk);
> +		exit_robust_list64(tsk, tsk->robust_list);
>  		tsk->robust_list = NULL;
>  	}
>  #else
>  	if (unlikely(tsk->robust_list)) {
> -		exit_robust_list32(tsk);
> +		exit_robust_list32(tsk, (struct robust_list_head32 *) tsk->robust_list);
>  		tsk->robust_list = NULL;
>  	}
>  #endif
>  
>  #ifdef CONFIG_COMPAT
>  	if (unlikely(tsk->compat_robust_list)) {
> -		exit_robust_list32(tsk);
> +		exit_robust_list32(tsk, tsk->compat_robust_list);
>  		tsk->compat_robust_list = NULL;
>  	}
>  #endif
> +	/*
> +	 * Walk through the linked list, parsing robust lists and freeing the
> +	 * allocated lists
> +	 */
> +	if (unlikely(!list_empty(list2))) {
> +		list_for_each_entry_safe(curr, n, list2, list) {
> +			if (curr->head != NULL) {
> +				if (curr->list_type == ROBUST_LIST_64BIT)
> +					exit_robust_list64(tsk, curr->head);
> +				else if (curr->list_type == ROBUST_LIST_32BIT)
> +					exit_robust_list32(tsk, curr->head);
> +				curr->head = NULL;
> +			}
> +			list_del_init(&curr->list);
> +			kfree(curr);
> +		}
> +	}
>  
>  	if (unlikely(!list_empty(&tsk->pi_state_list)))
>  		exit_pi_state_list(tsk);

I'm still digesting this, but the above seems particularly silly.

Should not the legacy lists also be on the list of lists? I mean, it
makes no sense to have two completely separate means of tracking lists.

