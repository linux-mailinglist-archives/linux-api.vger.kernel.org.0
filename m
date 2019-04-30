Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A675AEFD5
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 07:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfD3FP1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Apr 2019 01:15:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfD3FP1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Apr 2019 01:15:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3U5DdOU077447
        for <linux-api@vger.kernel.org>; Tue, 30 Apr 2019 01:15:26 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s6ep62vr6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-api@vger.kernel.org>; Tue, 30 Apr 2019 01:15:25 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-api@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Tue, 30 Apr 2019 06:15:23 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Apr 2019 06:15:20 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3U5FJdV45940900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 05:15:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1064A4067;
        Tue, 30 Apr 2019 05:15:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85C77A406B;
        Tue, 30 Apr 2019 05:15:19 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Apr 2019 05:15:19 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C04A3A01D2;
        Tue, 30 Apr 2019 15:15:17 +1000 (AEST)
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
To:     Daniel Axtens <dja@axtens.net>, Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr <cmr@informatik.wtf>
References: <20190404003249.14356-1-matthewgarrett@google.com>
 <20190404003249.14356-2-matthewgarrett@google.com>
 <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
 <CACdnJus9AhAAYs-R94BH7HDuuQfXjgdhdqUR6Pvk9mxbuPx1=Q@mail.gmail.com>
 <87wojdy8ro.fsf@dja-thinkpad.axtens.net>
 <87tvehxvh0.fsf@dja-thinkpad.axtens.net>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Tue, 30 Apr 2019 15:15:17 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87tvehxvh0.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19043005-0016-0000-0000-00000276B77E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19043005-0017-0000-0000-000032D3404F
Message-Id: <b56f7fbe-f87a-0af7-f447-4bfee712ce16@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=831 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904300034
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 29/4/19 2:54 pm, Daniel Axtens wrote:
> Hi,
> 
>>>> I'm thinking about whether we should lock down the powerpc xmon debug
>>>> monitor - intuitively, I think the answer is yes if for no other reason
>>>> than Least Astonishment, when lockdown is enabled you probably don't
>>>> expect xmon to keep letting you access kernel memory.
>>>
>>> The original patchset contained a sysrq hotkey to allow physically
>>> present users to disable lockdown, so I'm not super concerned about
>>> this case - I could definitely be convinced otherwise, though.
> 
> So Mimi contacted me offlist and very helpfully provided me with a much
> better and less confused justification for disabling xmon in lockdown:
> 
> On x86, physical presence (== console access) is a trigger to
> disable/enable lockdown mode.
> 
> In lockdown mode, you're not supposed to be able to modify memory. xmon
> allows you to modify memory, and therefore shouldn't be allowed in
> lockdown.
> 
> So, if you can disable lockdown on the console that's probably OK, but
> it should be specifically disabling lockdown, not randomly editing
> memory with xmon.

That makes sense.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

