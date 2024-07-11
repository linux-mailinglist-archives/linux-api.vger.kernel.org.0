Return-Path: <linux-api+bounces-1932-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 804C692EDAF
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3DD3B2124F
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC12A16D9D4;
	Thu, 11 Jul 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dv9KCko5"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF1A16B72E
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718681; cv=none; b=O7ZQKdDuzDx30e5xlxdK5LuP/7lI/6PgRk/b0r+5GRTp/lS+n2EkQypiv6ezoVjogmBobZKWsHEeI2+5yaW6zma74LnRRAtQHxl8UlUFh2NyUlDb1NMr+HwxThOTiQMGPNWiMxDRsqjXp77k65xSWHap99ncaKw071KWjj+DPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718681; c=relaxed/simple;
	bh=aK5fGxfzkfaF8CjDF+AftR41H/5Cb8VT2TGnJRgpefE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPdGP7/M0RABMQWE73fQVKV3VZrf5vR+dD/TweyHuzM+L8438FzShFyNAQ+0iT4banxWsotd0wUR/EQmMNARNBgP+YD1NyaIrZVnCq3LqqyhN2LlvupS1bLOjwVurv9XNVzH1C/Nfiun2zf3wpp7cGhfidC2DQl297dQnSiz91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dv9KCko5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720718679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LHcQAftkTM3ozuP6bogHJjs0mv0L9m4CNnKaf7CG7SA=;
	b=Dv9KCko52MUMX4fb493XcB62h9Tv5W1z0NapiTZLgrKejKX8i8EAr2qSHFauTUye+Ptu9f
	O4X+gOK1LZJaUaCA7/JFE+JvBKrYDEZwvNMxdR1y78fPHJBhq8yHb5JP5/6Pw2ZSMZHIQ1
	621z3vSOlWIuBxqg49NSspWkF1R9rfw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Bkp4DBASPyOQfiGiHrAr0g-1; Thu, 11 Jul 2024 13:24:36 -0400
X-MC-Unique: Bkp4DBASPyOQfiGiHrAr0g-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70b201c6ce2so1288661b3a.2
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 10:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720718675; x=1721323475;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LHcQAftkTM3ozuP6bogHJjs0mv0L9m4CNnKaf7CG7SA=;
        b=gt0oAHu9M7Qv3HKNZ9DBYMmcdYYU7CbVn/pbcmE78LXhEohxjEt00mI9uV8fXmqIEg
         3tSLJYPY4nde8hh2ahZeGcNpQmKIOifl/b5eeJe0zekszSy8293eZqDGwXAhyUHSEZRY
         ytiwQVG+5SoYzMnv8tIItS1gwvWhJmudKKDfrtYjr8cBkgikWw98WFtbaydKL/KTHX9A
         +FkBxaP9xGfFOdoihEKPAbhWZ+0QgKzlrViFjIJ15vQs7Q4UJ+P2PYQZhn/uoxne1VY+
         RcU8PeRqdquIfzYlNIgPCQwDcqVZD5xAws6GV8qKZd6ugiVfmeqd315ptKpXWRfWUkkV
         64gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRtGeS9SkO1ODTv8meJdxat3f21Qs9KvNNdtcJcG30WGtQPSvUYhtRv5xfDs9tTxTYFJpMKFeBWwz36ZnaCV9zcRHUM68qtckY
X-Gm-Message-State: AOJu0YydNvYhU0IzRXl1lM85+BdjjuxcBO+kf/zoSEMDzjJmEo9PlvpQ
	Kczkq5K982FJI8+c0ot7EAwXWHOFLhj5hJikyx7hivRLIDCmfeSX/QcznsfN9eCVU16VbZUaEmR
	G9JLxor40l1gzi7X6uwVj3m/nyGo+8ycxIEUVsq7Hn+qV1znirbdP+m0C5Q==
X-Received: by 2002:a05:6a20:4303:b0:1c0:bf35:ef4c with SMTP id adf61e73a8af0-1c29821493emr10965286637.11.1720718675294;
        Thu, 11 Jul 2024 10:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4gq5Y/9m136LJj8IjW2RDY4xHAx+IMxnZfYhFOWR09eQ5+olsjCd/jwDFzgTYIuyLaMXLfg==
X-Received: by 2002:a05:6a20:4303:b0:1c0:bf35:ef4c with SMTP id adf61e73a8af0-1c29821493emr10965253637.11.1720718674833;
        Thu, 11 Jul 2024 10:24:34 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac5431sm53033315ad.229.2024.07.11.10.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 10:24:34 -0700 (PDT)
Message-ID: <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
Date: Thu, 11 Jul 2024 19:24:33 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
 x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com> <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com> <ZpATx21F_01SBRnO@zx2c4.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZpATx21F_01SBRnO@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 19:17, Jason A. Donenfeld wrote:
> On Thu, Jul 11, 2024 at 07:09:36PM +0200, Jason A. Donenfeld wrote:
>> So, hmm... The swapbacked thing really seemed so simple... I wonder if
>> there's a way of recovering that.
> 
> Not wanting to introduce a new bitflag, I went looking and noticed this:
> 
> /*
>   * Private page markings that may be used by the filesystem that owns the page
>   * for its own purposes.
>   * - PG_private and PG_private_2 cause release_folio() and co to be invoked
>   */
> PAGEFLAG(Private, private, PF_ANY)
> PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
> PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
>          TESTCLEARFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
> 
> The below +4/-1 diff is pretty hacky and might be illegal in the state
> of California, but I think it does work. The idea is that if that bit is
> normally only used for filesystems, then in the anonymous case, it's
> free to be used for this.
> 
> Any opinions about this, or a suggestion on how to do that in a less
> ugly way?
> 
> Jason
> 
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1f9b5a9cb121..090554277e4a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1403,6 +1403,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>   	 */
>   	if (!(vma->vm_flags & VM_DROPPABLE))
>   		__folio_set_swapbacked(folio);
> +	else
> +		folio_set_owner_priv_1(folio);


PG_owner_priv_1 maps to PG_swapcache? :)

-- 
Cheers,

David / dhildenb


