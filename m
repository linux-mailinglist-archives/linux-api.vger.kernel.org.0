Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78668F0935
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 23:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfKEWUG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 17:20:06 -0500
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:36375 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbfKEWUG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 17:20:06 -0500
Received: from smtp7.infomaniak.ch (smtp7.infomaniak.ch [83.166.132.30])
        by smtp-sh2.infomaniak.ch (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id xA5MJ23o058900
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Nov 2019 23:19:03 +0100
Received: from ns3096276.ip-94-23-54.eu (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp7.infomaniak.ch (8.14.5/8.14.5) with ESMTP id xA5MIuNt039378
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Tue, 5 Nov 2019 23:18:56 +0100
Subject: Re: [PATCH bpf-next v13 4/7] landlock: Add ptrace LSM hooks
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        Florent Revest <revest@chromium.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        John Johansen <john.johansen@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        KP Singh <kpsingh@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>, bpf@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org
References: <20191104172146.30797-1-mic@digikod.net>
 <20191104172146.30797-5-mic@digikod.net>
 <20191105171824.dfve44gjiftpnvy7@ast-mbp.dhcp.thefacebook.com>
 <23acf523-dbc4-855b-ca49-2bbfa5e7117e@digikod.net>
 <20191105193446.s4pswwwhrmgk6hcx@ast-mbp.dhcp.thefacebook.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Openpgp: preference=signencrypt
Message-ID: <38309064-89c2-8e01-b619-4459e0d58311@digikod.net>
Date:   Tue, 5 Nov 2019 23:18:55 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20191105193446.s4pswwwhrmgk6hcx@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 05/11/2019 20:34, Alexei Starovoitov wrote:
> On Tue, Nov 05, 2019 at 07:01:41PM +0100, Micka�l Sala�n wrote:
>>
>> On 05/11/2019 18:18, Alexei Starovoitov wrote:
>>> On Mon, Nov 04, 2019 at 06:21:43PM +0100, Micka�l Sala�n wrote:
>>>> Add a first Landlock hook that can be used to enforce a security policy
>>>> or to audit some process activities.  For a sandboxing use-case, it is
>>>> needed to inform the kernel if a task can legitimately debug another.
>>>> ptrace(2) can also be used by an attacker to impersonate another task
>>>> and remain undetected while performing malicious activities.
>>>>
>>>> Using ptrace(2) and related features on a target process can lead to a
>>>> privilege escalation.  A sandboxed task must then be able to tell the
>>>> kernel if another task is more privileged, via ptrace_may_access().
>>>>
>>>> Signed-off-by: Micka�l Sala�n <mic@digikod.net>
>>> ...
>>>> +static int check_ptrace(struct landlock_domain *domain,
>>>> +		struct task_struct *tracer, struct task_struct *tracee)
>>>> +{
>>>> +	struct landlock_hook_ctx_ptrace ctx_ptrace = {
>>>> +		.prog_ctx = {
>>>> +			.tracer = (uintptr_t)tracer,
>>>> +			.tracee = (uintptr_t)tracee,
>>>> +		},
>>>> +	};
>>>
>>> So you're passing two kernel pointers obfuscated as u64 into bpf program
>>> yet claiming that the end goal is to make landlock unprivileged?!
>>> The most basic security hole in the tool that is aiming to provide security.
>>
>> How could you used these pointers without dedicated BPF helpers? This
>> context items are typed as PTR_TO_TASK and can't be used without a
>> dedicated helper able to deal with ARG_PTR_TO_TASK. Moreover, pointer
>> arithmetic is explicitly forbidden (and I added tests for that). Did I
>> miss something?
> 
> It's a pointer leak.

The lifetimes of the pointers are scoped by the two LSM hooks that
expose them. The LSM framework guarantee that they are safe to use in
this context.

> 
>>
>>>
>>> I think the only way bpf-based LSM can land is both landlock and KRSI
>>> developers work together on a design that solves all use cases.
>>
>> As I said in a previous cover letter [1], that would be great. I think
>> that the current Landlock bases (almost everything from this series
>> except the seccomp interface) should meet both needs, but I would like
>> to have the point of view of the KRSI developers.
>>
>> [1] https://lore.kernel.org/lkml/20191029171505.6650-1-mic@digikod.net/
>>
>>> BPF is capable
>>> to be a superset of all existing LSMs whereas landlock and KRSI propsals today
>>> are custom solutions to specific security concerns. BPF subsystem was extended
>>> with custom things in the past. In networking we have lwt, skb, tc, xdp, sk
>>> program types with a lot of overlapping functionality. We couldn't figure out
>>> how to generalize them into single 'networking' program. Now we can and we
>>> should. Accepting two partially overlapping bpf-based LSMs would be repeating
>>> the same mistake again.
>>
>> I'll let the LSM maintainers comment on whether BPF could be a superset
>> of all LSM, but given the complexity of an access-control system, I have
>> some doubts though. Anyway, we need to start somewhere and then iterate.
>> This patch series is a first step.
> 
> I would like KRSI folks to speak up. So far I don't see any sharing happening
> between landlock and KRSI. You're claiming this set is a first step. They're
> claiming the same about their patches. I'd like to set a patchset that was
> jointly developed.

With all due respect, Landlock got much more feedback than KRSI and I
think this thirteenth Landlock patch series is more mature than the
first KRSI RFC. I'm open to concrete suggestions and I'm willing to
collaborate with the KRSI folks if they want to. However, I'm OK if they
don't want to use Landlock as a common ground, and I don't think it
should be a blocker for any of the projects.

Perfect is the enemy of good. ;)
