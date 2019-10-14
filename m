Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54AFCD6608
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbfJNPVK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Oct 2019 11:21:10 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:37361 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732422AbfJNPVK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Oct 2019 11:21:10 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 33E4528A;
        Mon, 14 Oct 2019 11:21:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 14 Oct 2019 11:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kellner.me; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=mesmtp;
         bh=Bpli2FWy4jaHCUTgQsgpxLtikyXA6zeohU0YjZLav+0=; b=cnTdk+aPBhLQ
        RB9mkNzWt1BbAsarP5ESPmvVG5xVA4jJGnH+3xZKOTziUD5IP4+WNda1ygjP8y+O
        DdlVxYEAPChb50nWfJBwjBUqx7NabNPKRnzo5+4IlDB5vkzloR7lbFtZS6/kC47c
        TRGRryefE+TAjib5H+Gn5XGS9q/L/Fs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Bpli2FWy4jaHCUTgQsgpxLtikyXA6zeohU0YjZLav
        +0=; b=GxnClzyXLTyOCtlZSuewxWNVbdkJeCwQPJcxZvb+k2BBdF63NKVYfn1Og
        +s9hkpmfO6Uo5zibJu3n1PfRcCaLS7X2GjVqclXZge1p3Wq+j+PHBaKfkAj5xonQ
        vCNbGti9eitwO5re39TcLw9VzZ1mykm6jHrOgsoro+IWx5FXIvr58zzxuNPgpfqm
        WQMHlR4TDWXd4JYyFCttqeSPLVJRHQqpkUjjewQykI5PJiuutfZ39/IfHmQngcAm
        GltldxS+qZeginB1cAs7jWf+xw+F/dCqTvchFEEGM30GFxxTMG7pf78tjxszMH2R
        m2UAiddZcHygd8JMibe7pxzIOOGrw==
X-ME-Sender: <xms:YZKkXespN5Z2dZkG56i25yWI23XZrnlaGCO9gLLXApNysBl9sfHNgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjedugdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeevhhhrihhs
    thhirghnucfmvghllhhnvghruceotghhrhhishhtihgrnheskhgvlhhlnhgvrhdrmhgvqe
    enucfkphepkeelrdduiedrudehfedrudelieenucfrrghrrghmpehmrghilhhfrhhomhep
    tghhrhhishhtihgrnheskhgvlhhlnhgvrhdrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:YZKkXWsDSCi96XxkaLPYxbm-YRdtRrJPeklcLGqkpFpxi4J-QPPqFg>
    <xmx:YZKkXTMaKrOaW1aCoPC5BF8uzxnqSlVrC9AXNQD_r4MxkygbOrdZOA>
    <xmx:YZKkXU113Of1FbUAl3z8_fIxuX-86l8714lG-aL9gsJ6h8mQYIwaAg>
    <xmx:Y5KkXYBS8kn1Hvt5CXWDbzf4p_QMSbziZoBP7UYgsGAQWFPM7yZhW5j8AYY>
Received: from hanada.ber.coreos.systems (cable-89-16-153-196.cust.telecolumbus.net [89.16.153.196])
        by mail.messagingengine.com (Postfix) with ESMTPA id 68FD1D6005D;
        Mon, 14 Oct 2019 11:21:02 -0400 (EDT)
Message-ID: <3159d545105613416961ff50572f6686cdee03ee.camel@kellner.me>
Subject: Re: [PATCH] pidfd: add NSpid entries to fdinfo
From:   Christian Kellner <christian@kellner.me>
To:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 14 Oct 2019 17:20:57 +0200
In-Reply-To: <CAG48ez1Yf05j2irdZxT2TA=2n3xo25KN48nRQdp_F8j14K36rA@mail.gmail.com>
References: <CAG48ez1hk9d-qAPcRy9QOgNuO8u3Y_hu_3=GZoFYLY+oMdo8xg@mail.gmail.com>
         <20191012101922.24168-1-christian.brauner@ubuntu.com>
         <20191012102119.qq2adlnxjxrkslca@wittgenstein>
         <abc477fb3bd8fbf7b4d7e53d079dd1d8902e54af.camel@kellner.me>
         <20191014103157.h2wph2ujjidsrhyw@wittgenstein>
         <CAG48ez1Yf05j2irdZxT2TA=2n3xo25KN48nRQdp_F8j14K36rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 2019-10-14 at 17:10 +0200, Jann Horn wrote:
> On Mon, Oct 14, 2019 at 12:32 PM Christian Brauner wrote:
> > On Mon, Oct 14, 2019 at 11:43:01AM +0200, Christian Kellner wrote:
> > You could probably do:
> > 
> > #ifdef CONFIG_PID_NS
> > seq_put_decimal_ull(m, "\nNSpid:\t", nr);
> > for (i = ns->level + 1; i <= pid->level && nr; i++)
> >         seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);
> > #endif
> 
> Personally, I dislike hiding the precondition for running the loop in
> the loop statement like that. While it makes the code more concise,
> it somewhat obfuscates the high-level logic at a first glance.
I agree and it has the side-effect of needing another #ifdef at the end
of the variable block for "i". I think I will go with:

if (nr) {
	int i;

	/* If nr is non-zero it means that 'pid' is valid and that
	 * ns, i.e. the pid namespace associated with the procfs
	 * instance, is in the pid namespace hierarchy of pid.
	 * Start at one below the already printed level.
	 */
	for (i = ns->level + 1; i <= pid->level; i++)
		seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);
}

I will re-work the comment block and then send a new version of
the patch.

Thanks,
Christian

