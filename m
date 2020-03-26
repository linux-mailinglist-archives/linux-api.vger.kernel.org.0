Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F97C193F27
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 13:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgCZMru (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 08:47:50 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48598 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgCZMru (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 08:47:50 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jHRvI-0004FF-F4; Thu, 26 Mar 2020 06:47:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jHRvH-0005af-Mz; Thu, 26 Mar 2020 06:47:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
References: <20200325120345.12946-1-vbabka@suse.cz>
        <874kuc5b5z.fsf@x220.int.ebiederm.org>
        <20200326065829.GC27965@dhcp22.suse.cz>
Date:   Thu, 26 Mar 2020 07:45:13 -0500
In-Reply-To: <20200326065829.GC27965@dhcp22.suse.cz> (Michal Hocko's message
        of "Thu, 26 Mar 2020 07:58:29 +0100")
Message-ID: <87bloj2skm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jHRvH-0005af-Mz;;;mid=<87bloj2skm.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19UwF8u5e2QvQbuXdnuXgW+a4jTDraswv0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3504]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 364 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 15 (4.1%), b_tie_ro: 13 (3.5%), parse: 1.12
        (0.3%), extract_message_metadata: 15 (4.2%), get_uri_detail_list: 2.4
        (0.6%), tests_pri_-1000: 17 (4.7%), tests_pri_-950: 1.44 (0.4%),
        tests_pri_-900: 1.15 (0.3%), tests_pri_-90: 69 (19.0%), check_bayes:
        68 (18.5%), b_tokenize: 7 (1.9%), b_tok_get_all: 10 (2.8%),
        b_comp_prob: 3.1 (0.8%), b_tok_touch_all: 42 (11.7%), b_finish: 1.24
        (0.3%), tests_pri_0: 229 (63.0%), check_dkim_signature: 0.76 (0.2%),
        check_dkim_adsp: 2.9 (0.8%), poll_dns_idle: 1.28 (0.4%), tests_pri_10:
        2.4 (0.7%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters from kernel command line
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Wed 25-03-20 17:20:40, Eric W. Biederman wrote:
>> Vlastimil Babka <vbabka@suse.cz> writes:
> [...]
>> > +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
>> > +		return 0;
>> 
>> Is there any way we can use a slash separated path.  I know
>> in practice there are not any sysctl names that don't have
>> a '.' in them but why should we artifically limit ourselves?
>
> Because this is the normal userspace interface? Why should it be any
> different from calling sysctl?
> [...]

Why should the kernel command line implement userspace whims?
I was thinking something like: "sysctl/kernel/max_lock_depth=2048"
doesn't look too bad and it makes things like reusing our
kernel internal helpers much easier.

Plus it suggest that we could do the same for sysfs files:
	"sysfs/kernel/fscaps=1"

And the code could be same for both cases except for the filesystem
prefix.

>> Further it will be faster to lookup the sysctls using the code from
>> proc_sysctl.c as it constructs an rbtree of all of the entries in
>> a directory.  The code might as well take advantage of that for large
>> directories.
>
> Sounds like a good fit for a follow up patch to me. Let's make this
> as simple as possible for the initial version. But up to Vlastimil of course.

I would argue that reusing proc_sysctl.c:lookup_entry() should make the
code simpler, and easier to reason about.

Especially given the bugs in the first version with a sysctl path.
A clean separation between separating the path from into pieces and
looking up those pieces should make the code more robust.

That plus I want to get very far away from the incorrect idea that you
can have sysctls without compiling in proc support.  That is not how
the code works, that is not how the code is tested.

It is also worth pointing out that:

	proc_mnt = kern_mount(proc_fs_type);
        for_each_sysctl_cmdline() {
        	...
		file = file_open_root(proc_mnt->mnt_root, proc_mnt, sysctl_path, O_WRONLY, 0);
		kernel_write(file, value, value_len);
        }
        kern_umount(proc_mnt);

Is not an unreasonable implementation.

There are problems with a persistent mount of proc in that it forces
userspace not to use any proc mount options.  But a temporary mount of
proc to deal with command line options is not at all unreasonable.
Plus it looks like we can have kern_write do all of the kernel/user
buffer silliness.

> [...]
>
>> Hmm.  There is a big gotcha in here and I think it should be mentioned.
>> This code only works because no one has done set_fs(KERNEL_DS).  Which
>> means this only works with strings that are kernel addresses essentially
>> by mistake.  A big fat comment documenting why it is safe to pass in
>> kernel addresses to a function that takes a "char __user*" pointer
>> would be very good.
>
> Agreed

Eric
