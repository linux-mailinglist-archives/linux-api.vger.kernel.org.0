Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4F331987
	for <lists+linux-api@lfdr.de>; Mon,  8 Mar 2021 22:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCHVqj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Mar 2021 16:46:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:59814 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhCHVqJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 8 Mar 2021 16:46:09 -0500
IronPort-SDR: B5BfdzVELFeXuc0ei0jP881xpC2yejmY7xv0AUR+cY2ZcRkEFWPEAFIL5JBjOYxQX4gkYI+XZj
 hCm74We0GaoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273136671"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="273136671"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 13:46:08 -0800
IronPort-SDR: av0sKWOYau6s6d1swTN7BWeVgPq3oopzECLt1zc/06mbPLQKb4uSXX12ehtGidmFX4YQT9Fmsz
 F2r7MAjtiJfw==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="376253165"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.186.31]) ([10.209.186.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 13:46:08 -0800
Subject: Re: [PATCH 2/2] sigaction.2: wfix - Clarify si_addr description.
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20210226172634.26905-1-yu-cheng.yu@intel.com>
 <20210226172634.26905-3-yu-cheng.yu@intel.com>
 <20210308212936.GD12548@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <40c3c4cc-e135-1355-51ee-4d0f16e47e71@intel.com>
Date:   Mon, 8 Mar 2021 13:46:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308212936.GD12548@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/8/2021 1:30 PM, Borislav Petkov wrote:
> On Fri, Feb 26, 2021 at 09:26:34AM -0800, Yu-cheng Yu wrote:
>> SIGSEGV fills si_addr only for memory access faults.  Add a note to clarify.
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Alejandro Colomar <alx.manpages@gmail.com>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Florian Weimer <fweimer@redhat.com>
>> Cc: "H.J. Lu" <hjl.tools@gmail.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-api@vger.kenel.org
>> Link: https://lore.kernel.org/linux-api/20210217222730.15819-7-yu-cheng.yu@intel.com/
>> ---
>>   man2/sigaction.2 | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/man2/sigaction.2 b/man2/sigaction.2
>> index 49a30f11e..bea884a23 100644
>> --- a/man2/sigaction.2
>> +++ b/man2/sigaction.2
>> @@ -467,7 +467,7 @@ and
>>   .BR SIGTRAP
>>   fill in
>>   .I si_addr
>> -with the address of the fault.
>> +with the address of the fault (see notes).
>>   On some architectures,
>>   these signals also fill in the
>>   .I si_trapno
>> @@ -955,6 +955,11 @@ It is not possible to block
>>   .IR sa_mask ).
>>   Attempts to do so are silently ignored.
>>   .PP
>> +In a
>> +.B SIGSEGV,
>> +if the fault is a memory access fault, si_addr is filled with the address
>> +causing the fault, otherwise it is not filled.
> 
> "... otherwise it is uninitialized." or "zeroed" or whatever...
> 
> And I'm having trouble figuring out why do you need to clarify this?
> 
> Because of this sentence:
> 
>         * SIGILL,  SIGFPE, SIGSEGV, SIGBUS, and SIGTRAP fill in si_addr with the address
>           of the fault.  On some architectures, these signals also fill in the si_trapno
>           field.
> 
> ?

I think the sentence above is vague, but probably for the reason that 
each arch is different.  Maybe this patch is unnecessary and can be dropped?

> 
> If so, did you audit all architectures whether si_addr is populated only
> on memory access faults or is this something POSIX dictates or what's
> up? Because the sigaction(2) manpage is arch-agnostic and this is a
> rather strong assertion.
> 
> What am I missing?
> 
> Thx.
>
