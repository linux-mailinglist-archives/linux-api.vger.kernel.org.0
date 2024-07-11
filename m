Return-Path: <linux-api+bounces-1946-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCA892EF93
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 21:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7806283FAF
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB516EBFE;
	Thu, 11 Jul 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OawjpUuD"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601C16EB6E
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725729; cv=none; b=DEzcdFNMYjAPXifpG7uILo3fCRjHXbhDqEpSfIfhi9Nr+g/wHkPEnYbUl9HGHU7NfqvAvRvzT4MHx6Uw199uWIAKwzhxxtREaDSa+mGCE5e5nzwCeqJ/GxCJJsQCA8rQcP8LTfrXo1kOkz/xCQmNieyyP/bpcSyYD3taULWOy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725729; c=relaxed/simple;
	bh=UuQSe5elIodowglY5d5g4Jy8uwN+MrQ4mBPXr9xFNoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltjmKN9WkVgiiM6Tdik1eBKs0QzJM6d9gjclm78fu9M/gAvQV/BPrjmeqaQpZzewA41TvTVZkjhqNdx7vvOLkbrYhp4bEVrWtnfIaAJ2J0yubyNcGTRSk8pDw41PExQ2Kn3YfsqgkBc1YDHYVJZCWfYwdDpzyC+VsMEE+kcqXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OawjpUuD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720725727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7LJ6DmYGSL/PRBaGAaHlYOKnbcmFoQylfgaO0zlxFrY=;
	b=OawjpUuDge3WouOwK5/LB6UhSEAhrDZZty9UrCzDKqYkrXzxbgdgrD5km+gzmZZD+uCWuo
	LYrjt2iLk2nzeMMSvW+/0IfzCZ8TXlBxeqxepBxgkz2grmfJ4ITxYceochKfmMDx2cLgv3
	k+9HCnBnyYoySXnluBJd0jGyQ6G+WjM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-jSX7c5ZMO06ZVir2W1E_uA-1; Thu, 11 Jul 2024 15:22:04 -0400
X-MC-Unique: jSX7c5ZMO06ZVir2W1E_uA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7163489149fso806673a12.3
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 12:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725723; x=1721330523;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7LJ6DmYGSL/PRBaGAaHlYOKnbcmFoQylfgaO0zlxFrY=;
        b=kU+fN2VsLHvJLTzPYFU0GxJ4yNP1Bx0FtmhSoQWPHo/cG9XCOgVTXxieddzwSAm5LG
         5RHDPD09JBgwfeUJcZsLNMrPp+Xyh5tMiYIO0//IHyhGBCO00szFpHpF/dcXbi1qqZHF
         cswwJQEbqKnowWmzY78R5pZsotu4/GGF8GJzAriISu4sJ8DIiOvog16+e+Cf9bgQvQj1
         Y4rh+RelBjj1nHm7s6DR3KPjTqagj7yjbL5eLt16ox6SYZVyN3stAgtxXW/G29oq6KuP
         G3MI/FKCnLZD78tunRDYEps5W2FkRZ8KRGgDCidIlOz+5nGntgLJ035vSga0cNznjMzJ
         Wbaw==
X-Forwarded-Encrypted: i=1; AJvYcCXXy3hZPcSsg1L68FdxQsMG5XmdxHL0WKzJD+GCNPexVx1QDKzvbTUSkgMCD/IlhWMS11gFmeb6SOKLV+dYUo9zX/mBbVvr0kIW
X-Gm-Message-State: AOJu0YzVyoJniVAd+oYYO4uZV0Fn5fRRetJJ0EHXWNo0tYL8CMkEnTjW
	KSwXghU1aeOSHofNhW1G+7eCiR3cDakpYOiBnThnPOeueEozT6u1yj00qZ6K8i3oQm3EmDULJZz
	AEuXWAuYcQuSdXj+EHpAirPQEnDOXIXhwsqC2kKQCREms/u6WCDx/GesXRw==
X-Received: by 2002:a05:6a21:6b0c:b0:1c2:3843:c7a with SMTP id adf61e73a8af0-1c29820c0dbmr10451799637.8.1720725723026;
        Thu, 11 Jul 2024 12:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjLPrz1WpAVqwOZv7CArY7c8yOP9gCK/5wnuuMAmVSV6kEKdazbm0VwGJ5zh8HXsO+xgxsuQ==
X-Received: by 2002:a05:6a21:6b0c:b0:1c2:3843:c7a with SMTP id adf61e73a8af0-1c29820c0dbmr10451777637.8.1720725722680;
        Thu, 11 Jul 2024 12:22:02 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf8fesm53976335ad.250.2024.07.11.12.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:22:02 -0700 (PDT)
Message-ID: <57efaa1f-e9b6-41e8-96d5-aea5bc102bb4@redhat.com>
Date: Thu, 11 Jul 2024 21:22:00 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, tglx@linutronix.de, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <ZpAR0CgLc28gEkV3@zx2c4.com>
 <CAHk-=whGE_w46zVk=7S0zOcWv4Dp3EYtuJtzU92ab3pSnnmpHw@mail.gmail.com>
 <37da7835-0d76-463e-b074-455e405b138b@redhat.com>
 <CAHk-=wjVc6cpSCJwAqrhPvwBbcQEOL2TEnCELfadhA=n1GN4Ww@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHk-=wjVc6cpSCJwAqrhPvwBbcQEOL2TEnCELfadhA=n1GN4Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 21:17, Linus Torvalds wrote:
> On Thu, 11 Jul 2024 at 12:08, David Hildenbrand <david@redhat.com> wrote:
>>
>> We also have these folio_mark_dirty() calls, for example in
>> unpin_user_pages_dirty_lock(). Hm ... so preventing the folio from
>> getting dirtied is likely shaky.
> 
> I do wonder if we should just disallow page pinning for these pages
> entirely. When the page can get replaced by zeroes at any time,
> pinning it doesn't make much sense.
> 
> Except we do have that whole "fast" case that intentionally doesn't
> take locks and doesn't have a vma. Darn.

Yeah, and I think it should all be simpler; we shouldn't have to 
special-case these cases everywhere.

Maybe we can just find a way to not do *folio_set_swapbacked() without a 
VMA.

-- 
Cheers,

David / dhildenb


