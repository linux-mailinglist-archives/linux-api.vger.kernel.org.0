Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044CE193BE0
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 10:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgCZJaI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 05:30:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:48234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgCZJaI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 26 Mar 2020 05:30:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3DF79AD08;
        Thu, 26 Mar 2020 09:30:04 +0000 (UTC)
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <202003251404.12A69348@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f250814f-2c04-7bbf-035d-1dedcb260335@suse.cz>
Date:   Thu, 26 Mar 2020 10:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202003251404.12A69348@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/25/20 10:21 PM, Kees Cook wrote:
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -1345,6 +1345,25 @@ void __weak free_initmem(void)
>>  	free_initmem_default(POISON_FREE_INITMEM);
>>  }
>>  
>> +static void do_sysctl_args(void)
>> +{
>> +#ifdef CONFIG_SYSCTL
>> +	size_t len = strlen(saved_command_line) + 1;
>> +	char *command_line;
>> +
>> +	command_line = kzalloc(len, GFP_KERNEL);
>> +	if (!command_line)
>> +		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
>> +
>> +	strcpy(command_line, saved_command_line);
> 
> No need to open-code this:
> 
> 	char *command_line;
> 
> 	command_line = kstrdup(saved_command_line, GFP_KERNEL);
> 	if (!command_line)
> 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> 

Ah, right. I admit I basically copy_pasted some other parse_args user.

>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index ad5b88a53c5a..18c7f5606d55 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -1980,6 +1980,68 @@ int __init sysctl_init(void)
>>  	return 0;
>>  }
>>  
>> +/* Set sysctl value passed on kernel command line. */
>> +int process_sysctl_arg(char *param, char *val,
>> +			       const char *unused, void *arg)
>> +{
>> +	size_t count;
>> +	char *remaining;
>> +	int err;
>> +	loff_t ppos = 0;
>> +	struct ctl_table *ctl, *found = NULL;
>> +
>> +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
>> +		return 0;
>> +
>> +	param += sizeof("sysctl.") - 1;
>> +
>> +	remaining = param;
>> +	ctl = &sysctl_base_table[0];
>> +
>> +	while(ctl->procname != 0) {
>> +		int len = strlen(ctl->procname);
>> +		if (strncmp(remaining, ctl->procname, len)) {
>> +			ctl++;
>> +			continue;
>> +		}
> 
> I think you need to validate that "len" is within "remaining" here
> first.

My reasoning was that if remaining terminates too early, the null byte would be
different from non-null byte in ctl->procname and thus strncmp will return it as
different?
And the reason I used len in strncmp there is only so it doesn't compare the
terminating null, because remaning can continue with ".foo" instead.

>> +		if (ctl->child) {
>> +			if (remaining[len] == '.') {
>> +				remaining += len + 1;
> 
> And that "len + 1" is still valid.

And since we passed strncmp(..., len), remaining[len] might be null byte, but
then we can still compare it with '.'.

But C strings are full of landmines.
