Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE7D5F54
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 11:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfJNJvA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Oct 2019 05:51:00 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:40583 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730872AbfJNJvA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Oct 2019 05:51:00 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Oct 2019 05:50:59 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 5D19F735;
        Mon, 14 Oct 2019 05:43:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 14 Oct 2019 05:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kellner.me; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=mesmtp;
         bh=g0eFRemBLYbt3Vj8rAn5r0iCJcP4iC+nMgPsp2aeyxQ=; b=m3pH2RmGh+mj
        wgvkt8KKNTsOw/RCIpYWpPBZ9rvYpsYphyRZ4YEAuhQHTYFsGa6SR22GK7aHS3BF
        kjKgFdK5SZpgFRxOdNyN36n/3I9JmIokiTyUqahDnD9DvVaMbeeE52QEnVRWV/Wq
        AFO9J3gtmaeGLYBMtulGsshEe90KKCQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=g0eFRemBLYbt3Vj8rAn5r0iCJcP4iC+nMgPsp2aey
        xQ=; b=fBdXfPY7DPkJHy3ntlbPfzGqGoe/3gzTG01r694FV4htyZypSAuCJ6qwJ
        uCzw1sWz+HpgCIo7uQLa9TB6z4TXqHxKiXGS9E/6Caywos3hNxCC/gjKHr7X99q+
        p2r7uKqq+IaKPAOjQwm87WGHMXpRRnTg136+xzlaAbHQXjgh2I0EoBRqbVG05WeD
        l9iJBDmAa8smMKTFfoLdPRJw0fTr5pXkdGw3v4Do7s/3op1bk67Jbbh9kS0NE6TT
        MjoqyEOUPckhDxg9gVMTcSXiCCaLajbpkvNzp9BgXIuPtZ2IW4FVsS1Ds8oPKxCd
        9PhMDv7Nqz/SYtcO0hBPflt5oIyVg==
X-ME-Sender: <xms:LEOkXXp57ew_RQs5nL-MEIIyL2yyaxsz0bzuyR4NxxtsnUFssL77ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjedugddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeevhhhrihhs
    thhirghnucfmvghllhhnvghruceotghhrhhishhtihgrnheskhgvlhhlnhgvrhdrmhgvqe
    enucfkphepkeelrdduiedrudehfedrudelieenucfrrghrrghmpehmrghilhhfrhhomhep
    tghhrhhishhtihgrnheskhgvlhhlnhgvrhdrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:LEOkXWR0v9fgMY1-TaHjvEQ9XWwFpBerHqNWmL-nvZfXCyL4GpewVA>
    <xmx:LEOkXW7PuSdgAhpFcUPXbcxytFTnX2ZyCSrHWkhmwI1cX409JEvbUg>
    <xmx:LEOkXaPMjwqqU0vq2AAH0R7Fk77oYoTzNyooSq30qDIW5Zh0-3FhDw>
    <xmx:LUOkXcTLCneCSW0YV5A1iIvhjvw1J2XhdkfVVA7RjyJAeImeb40M-xb2e7k>
Received: from hanada.local (cable-89-16-153-196.cust.telecolumbus.net [89.16.153.196])
        by mail.messagingengine.com (Postfix) with ESMTPA id AB6348005B;
        Mon, 14 Oct 2019 05:43:05 -0400 (EDT)
Message-ID: <abc477fb3bd8fbf7b4d7e53d079dd1d8902e54af.camel@kellner.me>
Subject: Re: [PATCH] pidfd: add NSpid entries to fdinfo
From:   Christian Kellner <christian@kellner.me>
To:     Christian Brauner <christian.brauner@ubuntu.com>, jannh@google.com
Cc:     aarcange@redhat.com, akpm@linux-foundation.org, cyphar@cyphar.com,
        elena.reshetova@intel.com, guro@fb.com, ldv@altlinux.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Date:   Mon, 14 Oct 2019 11:43:01 +0200
In-Reply-To: <20191012102119.qq2adlnxjxrkslca@wittgenstein>
References: <CAG48ez1hk9d-qAPcRy9QOgNuO8u3Y_hu_3=GZoFYLY+oMdo8xg@mail.gmail.com>
         <20191012101922.24168-1-christian.brauner@ubuntu.com>
         <20191012102119.qq2adlnxjxrkslca@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, 2019-10-12 at 12:21 +0200, Christian Brauner wrote:
> I think this might be more what we want.
Yep, indeed.

> I tried to think of cases where the first entry of Pid is not
> identical
> to the first entry of NSpid but I came up with none. Maybe you do,
> Jann?
Yeah, I don't think that can be the case. By looking at the source of
'pid_nr_ns(pid, ns)' a non-zero return means that a) 'pid' valid, ie.
non-null and b) 'ns' is in the pid namespace hierarchy of 'pid' (at
pid->level, i.e. "pid->numbers[ns->level].ns == ns").

> Christian, this is just a quick stab I took. Feel free to pick this
> up as a template.
Thanks! I slightly re-worked it, with the reasoning above in mind, to
get rid of one of the branches:

+#ifdef CONFIG_PID_NS
+	seq_put_decimal_ull(m, "\nNSpid:\t", nr);
+	if (nr) {
+		int i;
+
+		/* If nr is non-zero it means that 'pid' is valid and that
+		 * ns, i.e. the pid namespace associated with the procfs
+		 * instance, is in the pid namespace hierarchy of pid.
+		 * Start at one level below and print all descending pids.
+		 */
+		for (i = ns->level + 1; i <= pid->level; i++) {
+			ns = pid->numbers[i].ns;
+			seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, ns));
+		}
+	}
+#endif

But I now just realized that with the very same reasoning, if nr is
non-zero, we don't need to redo all the checks and can just do:

for (i = ns->level + 1; i <= pid->level; i++)
	seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);

If this sounds good to you I resend the patches with the change above.

Thanks,
Christian

