Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F59337AE1
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 18:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCKRdV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 12:33:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:20127 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhCKRdS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 11 Mar 2021 12:33:18 -0500
IronPort-SDR: eb+DX4zT7vlUhoK+8Pu5q/StOwvDvP16rF7BAVXI11GaycjZVPNm3Rb+MlhOGN/lMpVrrBxnFV
 YVMCFD28X+0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188744801"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="188744801"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 09:33:17 -0800
IronPort-SDR: 7nTfUYTCyxvlbXklxTKWUQYfL3Ji1/uqDy2CUA+u5DHk4Uyo8jl2fJyMjhbOlao6P7kvLaagWD
 9S3HhKgan3Jg==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="410683312"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.103.95]) ([10.212.103.95])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 09:33:17 -0800
Subject: Re: [PATCH 2/2] sigaction.2: wfix - Clarify si_addr description.
To:     Stefan Puiu <stefan.puiu@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc:     lnx-man <linux-man@vger.kernel.org>,
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
 <40c3c4cc-e135-1355-51ee-4d0f16e47e71@intel.com>
 <20210309143141.GD699@zn.tnic>
 <CACKs7VBLnQTc_RgnXk8X-XgVRvR5_uXY0wL0snW7P5iDjpb8fA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <92fa4a4b-3100-cbd3-47cb-11072e4c6844@intel.com>
Date:   Thu, 11 Mar 2021 09:33:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACKs7VBLnQTc_RgnXk8X-XgVRvR5_uXY0wL0snW7P5iDjpb8fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/11/2021 9:17 AM, Stefan Puiu wrote:
> Hi,
> 
> My 2 cents below.
> 
> On Tue, Mar 9, 2021, 16:33 Borislav Petkov <bp@alien8.de 
> <mailto:bp@alien8.de>> wrote:
> 
>     On Mon, Mar 08, 2021 at 01:46:07PM -0800, Yu, Yu-cheng wrote:
>      > I think the sentence above is vague, but probably for the reason
>     that each
>      > arch is different.  Maybe this patch is unnecessary and can be
>     dropped?
> 
>     Maybe.
> 
>     If you want to clarify it, you should audit every arch. But what
>     would that bring? IOW, is it that important to specify when si_addr
>     is populated and when not...? I don't know of an example but I'm
>     no userspace programmer anyway, to know when this info would be
>     beneficial...
> 
> 
> I've worked on projects where the SIGSEGV sig handler would also print 
> si_addr. When diagnosing a crash, the address that triggered the fault 
> is useful to know. If you can't reproduce the crash in a debugger, or 
> there's no core dump, at least you have an idea if it's a NULL pointer 
> dereference or some naked pointer dereferencing. So I think it's useful 
> to know when si_addr can be used to infer such information and when not.

At least for x86, the faulting ip is already in ucontext, and si_addr is 
mostly the memory address being accessed if that was the reason of the 
fault (i.e. the memory is not supposed to be accessed).  That way, the 
signal handler has both the instruction pointer and the memory address.

For shadow stack violation, for example, it is not because the memory 
being accessed; it is the instruction itself causing the violation.  It 
is unnecessary to duplicate the ip in si_addr.  Setting si_addr to zero 
also indicates this is not a memory type fault.

--
Yu-cheng
