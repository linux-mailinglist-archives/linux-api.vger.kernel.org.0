Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095D31988F1
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 02:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgCaAeS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 20:34:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10780 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgCaAeS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 20:34:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e828fd80000>; Mon, 30 Mar 2020 17:33:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Mar 2020 17:34:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Mar 2020 17:34:16 -0700
Received: from [10.2.57.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 00:34:15 +0000
Subject: Re: [PATCH 3/3] kernel/hung_task convert hung_task_panic boot
 parameter to sysctl
To:     Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-4-vbabka@suse.cz> <202003301042.97F3B00@keescook>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <13ae67d8-4b31-db20-7ba4-1602906a291e@nvidia.com>
Date:   Mon, 30 Mar 2020 17:34:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202003301042.97F3B00@keescook>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585614808; bh=obsV1UARPS0bhJ0G+nqxDoZVF3Y4NftMC1+6ch1S31A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CrcLjf5XXnta60pIlUd4E7H1NdfGknlCWJRtYGrj8ldZ6gZlN5X338rTi3VfumCcp
         v6TI7Cvuuv3N2tEDq2EX0Uei3cRAnqrwrtie5e8B6JFM3kYzc4MCv+XmGseiFHfsLy
         3AvrSXk5ILdH3+4NLwFMo41stsmpqcyBTuyFbTaFWnJz++1GMdPNlWUje9jzy6iN4E
         f6XKURucBI7rkG5Kp0lkEMoycC5oPK8Hj1noLpXGzMC28Hes2UJQjT5lhz5eyVDsLt
         zo5bXMyelp6WwkT76rCvwsumjM3iy5J2Now7sp2ZdnHYo7KoaLP/N3hYZOKSOn9hD/
         BSozNoXu4MhRg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/30/20 10:43 AM, Kees Cook wrote:
...
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 81ff626fc700..e0b8840404a1 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1457,7 +1457,7 @@
>>   			[KNL] Should the hung task detector generate panics.
>>   			Format: <integer>
>>   
>> -			A nonzero value instructs the kernel to panic when a
>> +			A value of 1 instructs the kernel to panic when a
>>   			hung task is detected. The default value is controlled
>>   			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
>>   			option. The value selected by this boot parameter can
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index 97eb0b552bf8..77b1b844b02b 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -1743,6 +1743,7 @@ struct sysctl_alias {
>>    */
>>   static const struct sysctl_alias sysctl_aliases[] = {
>>   	{"numa_zonelist_order",		"vm.numa_zonelist_order" },


Hi Vlastimil,

Maybe best to delete the above line? Because:

     a) it was added as an example, and now that you have a real use case in this patch,
        the example is no longer required, and

     b) numa_zonelist_order is deprecated, as a boot param. Adding support to it in this
        brand-new mechanism seems to be going a bit in the opposite direction of deprecation.

And, I don't think you really want all the sysctls to be enabled as boot params, right? Your
comment right above sysctl_aliases[] (shown in patch 2) sort of indicates that only some items
are meant to be both sysctl's and boot params. And that makes sense.

In fact, the sysctl_aliases[] is (or could be) effectively the whitelist that Luis Chamberlain
was requesting in another thread. A whitelist makes good sense, for the reasons Luis listed.
As such, keeping it limited to items that we want, seems like the way to go, IMHO.


thanks,
-- 
John Hubbard
NVIDIA


>> +	{"hung_task_panic",		"kernel.hung_task_panic" },
>>   	{ }
>>   };
>>   
>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>> index 14a625c16cb3..b22b5eeab3cb 100644
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -63,16 +63,6 @@ static struct task_struct *watchdog_task;
>>   unsigned int __read_mostly sysctl_hung_task_panic =
>>   				CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE;
>>   
>> -static int __init hung_task_panic_setup(char *str)
>> -{
>> -	int rc = kstrtouint(str, 0, &sysctl_hung_task_panic);
>> -
>> -	if (rc)
>> -		return rc;
>> -	return 1;
>> -}
>> -__setup("hung_task_panic=", hung_task_panic_setup);
>> -
>>   static int
>>   hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
>>   {
>> -- 
>> 2.25.1
>>
> 
