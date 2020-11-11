Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08E2AEF3D
	for <lists+linux-api@lfdr.de>; Wed, 11 Nov 2020 12:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKKLLY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Nov 2020 06:11:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgKKLLC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Nov 2020 06:11:02 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ABB4IAT028086;
        Wed, 11 Nov 2020 06:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=a7GYeCIndw+vH42T5BJBBl0Gwd4YVjpCmfNMRBBHDMo=;
 b=l0xvTGCoUoJQKgtzpjU2bUjANvQq87k9xGM8EqMk/VSMYUxF0UxOMwlVkDoXh5WAexM8
 62piQ2pClQFjjYjhOpf84x94kCw8W0zwtOoYf56Vx5Fo2dhQifBGBGAO0v3bpaCdT4qg
 tYdOE3L9v/Km7x8r/3EVVA8zLF5yOyBUOPgT39Xj0OEiNNIX2W+LYYpwVN3bTPxpQQbz
 EvnSoYLKXB45RF/LW91C1TojOmOyJkrcs9a+tSPhEA+9QlvWzSvkjaQcm1H2XepGLBiz
 P8aLGR+XxiEYhgrG9mj85IeAaUiJWNETCbCWttk/uqz8961a0zU58EMesftLTz/ifiPu Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34r6k05fdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 06:10:40 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ABB5cnR035879;
        Wed, 11 Nov 2020 06:10:40 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34r6k05fdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 06:10:40 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ABB7lUc012010;
        Wed, 11 Nov 2020 11:10:39 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 34nk79rrqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 11:10:39 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ABBAc0K14877238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 11:10:38 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C92B112062;
        Wed, 11 Nov 2020 11:10:38 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40EDF112064;
        Wed, 11 Nov 2020 11:10:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.151.95])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Nov 2020 11:10:36 +0000 (GMT)
Message-ID: <d408fdd7c8893844fd13410397644ef157430e25.camel@linux.ibm.com>
Subject: Re: [PATCH v14 7/8] signal: define the field siginfo.si_faultflags
From:   Haren Myneni <haren@linux.ibm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Date:   Wed, 11 Nov 2020 03:10:34 -0800
In-Reply-To: <878sbavuvy.fsf@x220.int.ebiederm.org>
References: <cover.1604523707.git.pcc@google.com>
         <0eb601a5d1906fadd7099149eb605181911cfc04.1604523707.git.pcc@google.com>
         <878sbavuvy.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110062
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 2020-11-09 at 19:54 -0600, Eric W. Biederman wrote:
> Peter you are patching buggy code for your siginfo extension can
> you please ignore vas-fault.c.  The code in vas-fault.c should
> be fixed separately.  Futher it uses clear_siginfo so you should
> get well defined behavior even if your new field is not initialized.
> 
> I have copied the powerpc folks so hopefully this buggy code
> can be fixed.
> 
> > diff --git a/arch/powerpc/platforms/powernv/vas-fault.c
> > b/arch/powerpc/platforms/powernv/vas-fault.c
> > index 3d21fce254b7..877e7d5fb4a2 100644
> > --- a/arch/powerpc/platforms/powernv/vas-fault.c
> > +++ b/arch/powerpc/platforms/powernv/vas-fault.c
> > @@ -154,6 +154,7 @@ static void update_csb(struct vas_window
> > *window,
> >  	info.si_errno = EFAULT;
> >  	info.si_code = SEGV_MAPERR;
> >  	info.si_addr = csb_addr;
> > +	info.si_faultflags = 0;
> 

Thanks Eric for your comments and pointing possible issues.

Here is the NX coprocessor interaction with user space and kernel:

- Process opens NX window / channel. The user space sends requests to
NX without kernel involvement. This request contains data buffer and
status block called coprocessor status block (CSB). 
- if NX sees fault on the request buffer or on CSB address, issue an
interrupt to kernel
- kernel updates the CSB with the fault information and then the
process can reissue request.
- If the fault is on CSB address and is not a valid address, sending
SEGV signal so that the process assign proper CSB and reissue new
request
- We are not seeing the invalid CSB address in the process context, but
during handling the fault later. So thought about sending SEGV signal
instead of killing the process since it is not a standard segfault. 
- All these windows will be closed upon process exit, but waits
until all pending requests are completed. So process will not exit with
pending requests, means after all faults handled if any. 
- In the case of multithread applications, NX windows will be closed
with the last thread. Means other threads can still issue requests with
these windows. So to support in these applications, take PID and MM
references during window open and release them later in close. 

> Powerpc folks.  This code was introduced in c96c4436aba4
> ("powerpc/vas:
> Update CSB and notify process for fault CRBs") and is badly buggy.
> 
> Let me count the bugs:
> 
> a) Using kill_pid_info.  That performs a permission check that
>    does not make sense from a kernel thread.
> 
> b) Manually filling in struct siginfo.  Everyone gets it wrong
>    and the powerpc code is no exception setting si_errno when
>    that is something Linux as a rule does not do.
> 
> Technically we have send_sig_fault to handle sending
> a fault from a non-sychrnous context but I am not convinced
> it make sense in this case.

Yes, kill_pid_info() -> group_send_sig_info() checks permissions which
is an extra step.  I think send_sig_fault may be used to replace the
above steps.

> 
> c) Sending an asynchronous SIGSEGV with the si_code set to
> SEGV_MAPERR.
>    How can userspace detect it is an asynchronous signal?  What can
>    userspace do if it detects an asynchronous signal?  If userspace
> is
>    so buggered as to give your kernel thread a bogus address I
> suspect
>    uncerimonious sending SIGKILL is probably the best you can do.

Application can assign new CSB and send new request when it catches the
signal. For example it can use csb_addr passed in si_addr amd decide
whether this SEGV is due to to CSB fault. Since it is an async signal,
was thinking for the application to recover instead of killing theprocess.  

> 
> There are some additional questionable things in that code like
> taking a
> task_struct reference simply to be able to test tsk->flags but no
> locks are held to ensure that tsk->flags are meaningful.  Nor are
> any tests performed to see if the task being tested still uses
> the designated mm.  I suspect exec could have been called.

tsk->flags is used to make sure not to send a signal if the task is in
exiting. We access this task under get/put_task_struct(). Also
kill_pid_info() sends signal if pid_task() is available. Since we are
taken mm reference, it can not be freed. 

So the task has to be present until all NX windows are closed.

> 
> In which case the code needs to check the mm, or at least play with
> exec_id to ensure you are not improperly signaling a process after
> exec.
> 
> None of this is to say that update_csb is fundmentally bad or hard to
> correct just that it has some significant defects in it's
> implementation
> right now that need to be corrected.  I am hoping a detailed
> accounting
> and pointing out those defects will allow the bug to be fixed.
> 
> Thank you,
> Eric

