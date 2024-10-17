Return-Path: <linux-api+bounces-2463-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CA9A307F
	for <lists+linux-api@lfdr.de>; Fri, 18 Oct 2024 00:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26791283021
	for <lists+linux-api@lfdr.de>; Thu, 17 Oct 2024 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D201D79B0;
	Thu, 17 Oct 2024 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RC5zm3Jt"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AF1D619E
	for <linux-api@vger.kernel.org>; Thu, 17 Oct 2024 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203094; cv=none; b=Tva+rfqJif82jS1xkHz7ulJdI78JQyoI7HBu1juaI36RQMlhCBsHs2HQzg8zeDGh4/9sol3rNqawgfA9KXr+qPRo61mViKlbkNOfqNoLTeRCuy/M/kky0x+fx3gnf8TZgFmMvuUcs5La+2/v95nemC7Lm7UfD5zpWSXFR1P8t1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203094; c=relaxed/simple;
	bh=z9Lkr5P4BndkKY4rV/RS7ZT7owQhpSNFjywZi1ZacJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbrYz5cdf6y6lwIH3VQnMmFF0zJgTFj0Skr4rGxEypV0xsDehhIjMwEtcUNKtUdwWjEDWVrZU18A0F9NmwXXUqUjd8xTiKUgSiMfZYtoMR1fFJ0TOwCaL2s99Yb1/CoM8DYFd4HxExxOooPDta8g+jTHmwx/DlbCHh/Dfr/jW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RC5zm3Jt; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83a9317f93dso71724639f.3
        for <linux-api@vger.kernel.org>; Thu, 17 Oct 2024 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729203086; x=1729807886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80fvdKHL+LkkjROKMT2nujzFhw5zymQ3Xd+BXMmYCek=;
        b=RC5zm3JtxIbt9zTOUTobgtYyC99FYqd2tt1w6m72zkzVHlJxUhpihY13JXVWypyX6E
         052dJQqx5VrfMjGNK/Af/X22lm7wwCaC4gl3jszUPNdFbdPNdMpa6vtTmIy9TtGin5hY
         0O6KjOd3rqu6QElBvOltRInXTKoYN9p2X2feM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729203086; x=1729807886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80fvdKHL+LkkjROKMT2nujzFhw5zymQ3Xd+BXMmYCek=;
        b=pywET8L8VRLP6qVwLH/eIw7P9kjrWATp+50R3BQwn1faPRz0i0ejmzDOXhT6JxhB15
         fVJbk0TCRxRiKY+tbsYVTrtVTy7ujaE9ummeSAnn9ypC9BiSLgFFkszLpJ5H5FT9ryQc
         DYJnnKaEs5p4sXAVNeJy0j4M2+e56mMRwri5KxSgxcL130fv37/kEB9WD7EvB1BDcbxm
         mHDfSAMuZZZj2/6kE+D8Ialkvngs0ugvcjI3vcXPx42sBqHLMEvvjxdeCRNJ47xGdQCe
         IvBdDYafCK+UUgT/qnEdWoBBUdeuK6PpbcoJYXGtab3Togk2UTF0LO7zAcl6tbiZ/koZ
         qKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX582ahQY2EZrgrYRUUsouiFkbmGfHMC7YGR/COWsRO9UNnJ6IuGS+ojfzjgOrIj+340Qen3qi7RTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZboKWtgcD4257m6EnshUwn75vXoiSGlk9rdh5ifZQU5+3KxQ
	SKrxA7z79ijkMNdtcMdrPbl8Gw+BCzF/PIgks5j8FhInCyaAMZHegwHPu7PDr5w=
X-Google-Smtp-Source: AGHT+IGRDu7myT8V60NfvWUuXuL9jKLj9q5dD9aFUZOLMttTXNFIQ4EOoYcRbPFcwugpa5vCSEVEHA==
X-Received: by 2002:a05:6e02:13a7:b0:3a0:a311:6773 with SMTP id e9e14a558f8ab-3a3f40b531fmr2839035ab.21.1729203086340;
        Thu, 17 Oct 2024 15:11:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3f3fd7e9bsm563435ab.4.2024.10.17.15.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 15:11:25 -0700 (PDT)
Message-ID: <f24e645f-e7e6-436d-875b-7e15feeae8eb@linuxfoundation.org>
Date: Thu, 17 Oct 2024 16:11:24 -0600
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] selftests: pidfd: add pidfd.h UAPI wrapper
To: John Hubbard <jhubbard@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <d8d1a8c6ade7f13a100a5c11fd1e53f7f2fddba3.1729198898.git.lorenzo.stoakes@oracle.com>
 <7df771b9-bfd6-465e-b0ba-12d2aab13ec6@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7df771b9-bfd6-465e-b0ba-12d2aab13ec6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/24 15:45, John Hubbard wrote:
> On 10/17/24 2:05 PM, Lorenzo Stoakes wrote:
>> Conflicts can arise between system fcntl.h and linux/fcntl.h, imported by
>> the linux/pidfd.h UAPI header.
>>
>> Work around this by adding a wrapper for linux/pidfd.h to
>> tools/include/ which sets the linux/fcntl.h header guard ahead of
>> importing the pidfd.h header file.
>>
>> Adjust the pidfd selftests Makefile to reference this include directory and
>> put it at a higher precidence than any make header installed headers to
>> ensure the wrapper is preferred.
> 
> ...but we are not actually using the installed headers, now. And we intend
> to continue avoiding them. So the ordering shouldn't matter. More below:
> 
>>
>> This way we can directly import the UAPI header file without issue, use the
>> latest system header file without having to duplicate anything.
>>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> ---
>>   tools/include/linux/pidfd.h            | 14 ++++++++++++++
>>   tools/testing/selftests/pidfd/Makefile |  3 +--
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>   create mode 100644 tools/include/linux/pidfd.h
>>
>> diff --git a/tools/include/linux/pidfd.h b/tools/include/linux/pidfd.h
>> new file mode 100644
>> index 000000000000..113c8023072d
>> --- /dev/null
>> +++ b/tools/include/linux/pidfd.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef _TOOLS_LINUX_PIDFD_H
>> +#define _TOOLS_LINUX_PIDFD_H
>> +
>> +/*
>> + * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
>> + * work around this by setting the header guard.
>> + */
>> +#define _LINUX_FCNTL_H
>> +#include "../../../include/uapi/linux/pidfd.h"
>> +#undef _LINUX_FCNTL_H
> 
> Oh shoot, I think you, Shuah and I were referring to different uapi locations,
> the whole time. And so the basic approach is different after all.
> 
> Your include path above actually refers to:
> 
>      $(top_srcdir)/include/uapi/linux/fcntl.h

Correct. I am glad we are on the same page now.

> 
> ...but what I was intending was to copy a snapshot of that file (or a
> snapshot from the one generated by "make headers"), to here:
> 
>      $(top_srcdir)/tools/include/uapi/linux/fcntl.h

So why do the copy and snapshot. Anytime you build userspace in the
reoo - you will need to run "make headers: whether you install
them under tools/include or include.

  
> 
> ...and then use $(TOOLS_INCLUDES), which is already in selftests/lib.mk,
> for that reason: to be available to all of the kselftests:
> 
>      TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi

Yes some tests do include that.

> 
> The reasoning for this directory is further explained here:
> 
>      tools/include/uapi/README
> 
> (And I see that selftests/proc has started using $(TOOLS_INCLUDES), that's
> progress.)

Yes the same problems apply here - what complicates this more is
selftests are supposed to test kernel changes, hence the need to
include latest kernel headers. The simple solution is adding a
dependency so we don't have to duplicate the headers. I don't
believe the perf solution works here. We will have to figure out
a solution.

> 
> And now, it's possible to change fcntl.h in place, instead of using a wrapper.
> Although either way seems OK to me. (I'm sort of ignoring the details of
> the actual header file conflict itself, for now.)
> 
> 
>> +
>> +#endif /* _TOOLS_LINUX_PIDFD_H */
>> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
>> index d731e3e76d5b..f5038c9dae14 100644
>> --- a/tools/testing/selftests/pidfd/Makefile
>> +++ b/tools/testing/selftests/pidfd/Makefile
>> @@ -1,8 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> -CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
>> +CFLAGS += -g -isystem $(top_srcdir)/tools/include $(KHDR_INCLUDES) -pthread -Wall
> 
> Instead, it would look like this, which now mostly matches selftests/mm/Makefile,
> which is also helpful, because eventually this can be factored into a common
> piece for all selftests:
> 
>      CFLAGS += -g -isystem $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall

KHDR_INCLUDES is "make headers" location under the root directory. So what
happens when you add TOOLS_INCLUDES to it.

Does "make kselftest-all" work as it is supposed to? If it and all tests
can build then I am all for it.

> 
> I apologize for just now noticing this! And these kselftests shouldn't require
> so much fussing around, I know. But once we get this just right, it will work
> well and last a long time. :)
> 


On the contrary if we don't discuss/fuss and get this right, we have to
deal with changes like adding local defines and adhoc approaches in
individual tests - that is one reason we made the "make headers"
as a dependency. I would like to solve the problem of proliferation
of local defines and even system calls in some cases.

For now I am going let this patch go through as it is important to
add tests.

My goals are simple:

- no local defines unless it is abslulutely necessary
- be able to build tests that add coverage for new kernel
   api and features before we release the kernel.
- make it easier for CIs to build and run tests
- continue to have tests works for kernel developres
   e.g: mm developers build tests in mm directory. They
   don't see the issues that crop up in CIs or running
   the entire kselftest default run like CIs do.

Adhoc changes break some use-cases.

thanks,
-- Shuah



