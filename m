Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE523A9FA9
	for <lists+linux-api@lfdr.de>; Wed, 16 Jun 2021 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhFPPj5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 16 Jun 2021 11:39:57 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49220 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbhFPPil (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Jun 2021 11:38:41 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltXag-0003Oh-TA; Wed, 16 Jun 2021 09:36:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltXaf-00Fvyj-5Z; Wed, 16 Jun 2021 09:36:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?utf-8?Q?Lu=C3=ADs?= Mendes <luis.p.mendes@gmail.com>,
        linux-api@vger.kernel.org
References: <CAEzXK1q7SR-CpMyP0jpdHx4GSCr5qkO_-+Dnn5xjmtVLSkDH0g@mail.gmail.com>
        <YMoKh90UsYkLV7Fh@kroah.com>
Date:   Wed, 16 Jun 2021 10:36:23 -0500
In-Reply-To: <YMoKh90UsYkLV7Fh@kroah.com> (Greg KH's message of "Wed, 16 Jun
        2021 16:28:23 +0200")
Message-ID: <87lf79keiw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1ltXaf-00Fvyj-5Z;;;mid=<87lf79keiw.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/BMi9MnV+q81GgrpB3tAxJmdMeSCQwTFg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_SpammyWords,
        XM_B_SpammyWords2,XM_B_Unicode,XM_Body_Obfu01 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3884]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  1.0 XM_Body_Obfu01 BODY: Obfuscations
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Greg KH <gregkh@linuxfoundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1051 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (1.1%), b_tie_ro: 10 (0.9%), parse: 2.2 (0.2%),
         extract_message_metadata: 28 (2.6%), get_uri_detail_list: 6 (0.5%),
        tests_pri_-1000: 29 (2.8%), tests_pri_-950: 2.1 (0.2%),
        tests_pri_-900: 1.70 (0.2%), tests_pri_-90: 275 (26.2%), check_bayes:
        273 (26.0%), b_tokenize: 17 (1.7%), b_tok_get_all: 12 (1.2%),
        b_comp_prob: 4.5 (0.4%), b_tok_touch_all: 234 (22.2%), b_finish: 1.03
        (0.1%), tests_pri_0: 603 (57.4%), check_dkim_signature: 1.00 (0.1%),
        check_dkim_adsp: 14 (1.4%), poll_dns_idle: 11 (1.1%), tests_pri_10:
        4.2 (0.4%), tests_pri_500: 88 (8.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Discussion of a possible modern alternate of the removed Sysctl syscall
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Jun 16, 2021 at 02:40:13PM +0100, Luís Mendes wrote:
>> Dear Linux kernel maintainers/developers,
>> 
>> 
>> I would like to discuss a modern alternate to Sysctl syscall and its
>> feasibility for armhf and aarch64 for supporting ioperm, iopl, inb,
>> outb and their siblings APIs emulation in Glibc, or even on an
>> external library to provide such sys/io.h API compatibility with
>> x86_64.
>> 
>> The advantage of having ioperm, iopl, inb and outb emulation for armhf
>
> What is "armhf"?
>
>> and aarch64 is that they can provide cross-compilation ability of
>> x86_64 applications and constitutes an easy and practical API for
>> simple I/O. This was not only useful for old ISA cards as it is today
>> for PCIe cards with I/O space, like I/O cards, LPT Parallel interface
>> cards, as well as many other cards that may have PCIe I/O space
>> (network cards, etc). PCIe LPT interface cards as well as
>> multi-function cards are still widely available, just search ebay or
>> amazon, and many suggestions will pop up.
>> 
>> I know for instance that LPT interface cards have their ppdev driver
>> which already provides an ioctl interface to access the card I/O
>> lines, but it is not performant for applications like bit-banging an
>> LPT card to load firmware into a micro-controller, for instance,
>> Microchip/ATMEL 8-bit micro-controllers. Plus the ioperm, iopl, inb,
>> outb has a simpler API for doing simple interactions with the I/O
>> space, like is the case with the IO lines of the LPT parallel
>> interface card.
>
> You should never use iopl, inb, and outb on modern systems, sorry.
> Please use the bus-specific ways to access the devices needed, or mmap
> the needed memory ranges into your program and directly access them that
> way if you know what you are doing for your specific hardware type (the
> UIO api provides this for you.)
>
>> There are many complaints in the web, like bug reports and
>> cross-compilation issues/reports regarding sys/io.h removal on armhf.
>> There are also people wishing for such functionality on aarch64.
>> 
>> 
>> I had an application working up to two years ago on two armhf systems
>> (armv7) on imx6q and mvebu architectures, to be concrete. The
>> application did and does just that, currently only for x84_64, but it
>> is able to bit-bang the ports to load the firmware into the chips. I
>> just didn't got to up-stream these quite small changes, like selecting
>> (in the kernel configuration):
>> General setup->Configure standard Kernel features (expert
>> users)->Sysctl syscall support->Enable
>> and do:
>> arch/arm/mach-imx/mach-imx6q.c, function __init imx6q_init_late(void)
>> and appended:
>> 
>>    register_isa_ports(0xfee0000, 0x1f80000, 0);
>> 
>> Which is the PCIe IO memory region in the imx6q memory map. It was
>> just a matter of up-streaming the change. It maybe also useful to
>> rename register_isa_ports to register_pci_ports, or so in the kernel,
>> to avoid this confusion regarding to ISA bus only applicability.
>
> As I stated above, you can access PCI IO memory regious through the UIO
> api and mmap them and talk directly to them if you want to.  There is no
> need to do old-style inb commands anymore for stuff like this, and
> hasn't been for decades now.
>
>> So I would like to have some opinions regarding the introduction of a
>> modern alternate for the sysctl syscall update in order to achieve
>> Glibc cross-compatibility for armhf and possibly aarch64 of what
>> already exists in Glibc for x86_64. What do you say?
>
> sysctl should not have anything to do with i/o accesses.  I don't know
> how that got somehow tied together in glibc, but that seems like a glibc
> issue, not a kernel one :)

There is somewhere a sysctl that provides information needed for the
emulation.  Base addresses or something like that.  I have only seen it
mentioned briefly.  This was one of the uses of sys_sysctl that
was mentioned in the first conversation about removing it.

The information should still be exported through /proc/sys/

Greg I will agree with you that whatever userspace is doing it should get
the information in a modern way that supports multiple busses or
at a bare minimum userspace should read the values it needs from
the files under /proc/sys.

I do sympathize as this appears to be a regression.  Even if not all of
the code was merged.

The use case is one I am familiar with bring up code wanting easy access
from userspace so people can experiment and figure out what is really
going on with the hardware.

Luis please see if you can use the interfaces that support multiple
busses.  That should be more robust in the future.  Especially if you
are bit-banging to load firmware or other userspace drivers, the is a
reasonable chance your hardware will appear on a system with multiple
busses someday and will actually need that support.

Eric

