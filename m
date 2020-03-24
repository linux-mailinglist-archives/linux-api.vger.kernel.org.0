Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B1C1916DF
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 17:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCXQux (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 12:50:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCXQux (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 24 Mar 2020 12:50:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 67515ABCF;
        Tue, 24 Mar 2020 16:50:50 +0000 (UTC)
Subject: Re: [RFC] kernel/sysctl: support setting sysctl parameters from
 kernel command line
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
References: <20200317132105.24555-1-vbabka@suse.cz>
 <202003171421.5DCADF51@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bc721358-6202-bdc5-0398-29921b3f9855@suse.cz>
Date:   Tue, 24 Mar 2020 17:50:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202003171421.5DCADF51@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/17/20 10:29 PM, Kees Cook wrote:
> On Tue, Mar 17, 2020 at 02:21:05PM +0100, Vlastimil Babka wrote:
>> A recently proposed patch to add vm_swappiness command line parameter in
>> addition to existing sysctl [1] made me wonder why we don't have a general
>> support for passing sysctl parameters via command line. Googling found only
>> somebody else wondering the same [2], but I haven't found any prior discussion
>> with reasons why not to do this.
> 
> I'd like to see stuff like this (as you say, you've found some
> redundancies here which could be cleaned up a bit). I think the reason
> it hasn't happened before is that the answers have mostly revolved
> around "just set it in your initramfs". :P
> 
>> [...]
>> Hence, this patch adds a new parse_args() pass that looks for parameters
>> prefixed by 'sysctl.' and searches for them in the sysctl ctl_tables. When
>> found, the respective proc handler is invoked. The search is just a naive
>> linear one, to avoid using the whole procfs layer. It should be acceptable,
>> as the cost depends on number of sysctl. parameters passed.
> 
> I think this needs reconsidering: this RFC only searches 1 level deep,
> but sysctls are a tree. For example:

Yes, that was an oversight, easily fixed.

> kernel.yama.ptrace_scope
> mm.transparent_hugepage.enabled

Hm, transparent_hugepage is in sysfs (/sys/kernel/mm), but not sysctl, at least
in my case the sysctl tool doesn't list it. Yours does? Yay for consistency.

> net.ipv4.conf.default.rp_filter
> ...etc
> 
> If this goes in, it'll need to do full traversal.

Right.

>> The main limitation of avoiding the procfs layer is however that sysctls
>> dynamically registered by register_sysctl_table() or register_sysctl_paths()
>> cannot be set by this method.
> 
> Correct. And I like what you've done in the code: announce any unhandled
> sysctls.
> 
>> The processing is hooked right before the init process is loaded, as some
>> handlers might be more complicated than simple setters and might need some
>> subsystems to be initialized. At the moment the init process can be started and
>> eventually execute a process writing to /proc/sys/ then it should be also fine
>> to do that from the kernel.
> 
> I agree about placement.
> 
>> 
>> [1] https://lore.kernel.org/linux-doc/BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com/
>> [2] https://unix.stackexchange.com/questions/558802/how-to-set-sysctl-using-kernel-command-line-parameter
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>> Hi,
>> 
>> this is an early RFC so I can get feedback whether to pursue this idea further,
>> before trying the more complicated stuff with dynamically registered sysctls.
>> For those I have some unanswered questions:
>> - Support them at all?
> 
> Maybe? It seems excessive for the initial version.

OK

>> - Do so by an internal procfs mount again, that was removed by 61a47c1ad3a4 ?
>>   Or try to keep it simple.
> 
> I think you can walk the registered sysctl structures themselves, yes?

I should be able to, yeah.

>> - If sysctls are dynamically registered at module load, process the command
>>   line sysctl arguments again? - this would be rather complicated I guess.
> 
> If it does get supported, perhaps saving them somewhere for
> register_sysctl_table() to walk when it gets called?
> 
> I like the idea if just for having to build less boiler plate for
> supporting things that I've had to plumb to both boot_params and sysctl.
> :)

Thanks, I will pursue the idea further then :)

Vlastimil
