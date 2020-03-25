Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834CF192B4B
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 15:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCYOg0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 10:36:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgCYOg0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Mar 2020 10:36:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38A0DAC50;
        Wed, 25 Mar 2020 14:36:24 +0000 (UTC)
Subject: Re: [RFC v2 2/2] kernel/sysctl: support handling command line aliases
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <20200325120345.12946-2-vbabka@suse.cz>
 <20200325142936.GC19542@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <52faea3b-6442-3b1b-9404-6a018d1d1c44@suse.cz>
Date:   Wed, 25 Mar 2020 15:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325142936.GC19542@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/25/20 3:29 PM, Michal Hocko wrote:
> Both patches look really great to me. I haven't really checked all the
> details but from a quick glance they both seem ok.

Thanks.

> I would just add a small clarification here. Unless I am mistaken
> early_param is called earlier than it would be now. But that shouldn't
> cause any problems because the underlying implementation is just a noop
> for backward compatibility.

Yeah, indeed worth noting somewhere explicitly. The conversion can't be done
blindly, one has to consider whether the delay compared to early_param can be a
disadvantage or not. For example the nmi_watchdog parameter is probably best
left as it is?

> Thanks a lot this looks like a very nice improvement.
> 
> On Wed 25-03-20 13:03:45, Vlastimil Babka wrote:
> [...]
>> -static __init int setup_numa_zonelist_order(char *s)
>> -{
>> -	if (!s)
>> -		return 0;
>> -
>> -	return __parse_numa_zonelist_order(s);
>> -}
>> -early_param("numa_zonelist_order", setup_numa_zonelist_order);
>> -
>>  char numa_zonelist_order[] = "Node";
>>  
>>  /*
>> -- 
>> 2.25.1
> 

