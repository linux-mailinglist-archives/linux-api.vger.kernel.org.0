Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAAD42A95C
	for <lists+linux-api@lfdr.de>; Tue, 12 Oct 2021 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJLQ1g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Oct 2021 12:27:36 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.135.51]:56847 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLQ1g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Oct 2021 12:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1634055934; x=1665591934;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DtHWogmbefTOZHJ1zHpA6HOO+MNBFrIhVE63j1QS6y4=;
  b=llE4hPPljvaT2XxEsi3vAwlxUh8fO66vdIKT83SOuqtAcOAAbbO/qise
   +4daTgpWTnZws979Iwy4GViqpmsFGX3WjjiilUKAOgurz3YyJfywxnnWv
   qQrZzQGZFtksCznHPDqUJN7o1eMcIu4w0b9esqjdbzySloLeNJsdzx2Y7
   Q=;
IronPort-Data: A9a23:tg1HLKwPIO6S1xzuzBh6t+fTxyrEfRIJ4+MujC+fZmUNrF6WrkUGm
 2AaUGqOOfaOYGGmfd5xbYu0oEkFuZSAmIdgT1Rs+FhgHilAwSbn6XV1DatS0we6dJCroJdPt
 p1GAjXmBJ5sFie0SjCFbeS68hGQ7UwML1bFILas1hpZHGeIcw98z0I+8wIFqtQw24HgW1rX4
 YmaT/D3YTdJ5RYlYwr41Ire8HuDjNyq0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatU88tqBe
 gr25OrRElU1XfsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0qS2TV1hUp/0l20c95NJ
 Nplrbi7TwICM5b3qb4SXjlcOWJ/IPJsweqSSZS/mZT7I0zueHzqxfVrVB1wNooe/Ot8HSdT6
 vUEJSoJaRfFjOveLLCTE7M9wJV8apOzbMVD4RmMzhmAZRoiaYzPTqHL/ttV9Covj9xDB/LZY
 IwSYFKDaTyaO0EeYQpOVfrSms+thCS4TQZ9lmibnq474nH2lQZM4bfyZY+9ltuiAJ89clyjj
 mDP+WL5Kh4dM9ObxHyO9XfErubRlCz6XqodE7q38vMsi1qWrkQLDwYVfVS8pva9hwi1XNc3A
 0YP9yUnqawa+0usQd3wGRa/pRasphwAc9VXFOI+5UeGza+8ywKYAHUUCzdZafQ4u8IsAz8nz
 FmEm5XuHzMHmLmUT2+Ns7SZtzW/PQALImIYIywJVw0I55/kuo5bpg7ASsZLFK+zk8HvHjfx0
 3aGoUAWgrQVgskjzai3/VnbxTmro/DhVgMp6x/FdmOj4BlwaIOsa8qv81ezxe5HN4WxVl6av
 z4FnKCjAPsmBpaLkiGGXKMQA7i16uyBNzqailcH84QdyglBMkWLJeh4iAyS7m8zWirYUVcFu
 HPuhD4=
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2021 12:25:32 -0400
Received: from [10.42.0.123] (10.32.190.116) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Oct 2021 12:25:31 -0400
Subject: Re: [PATCH 5/5 v0.6] sched/umcg: add
 Documentation/userspace-api/umcg.txt
To:     Peter Oskolkov <posk@posk.io>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>
References: <20210917180323.278250-1-posk@google.com>
 <20210917180323.278250-6-posk@google.com>
 <12eb2300-4a78-9e93-30a3-8e2ddba4693f@uwaterloo.ca>
 <CAFTs51W6ZHrGaoXEbXNCkVKLxe7_S2raYcXMBzypC7VUDMrU-w@mail.gmail.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <e162fdea-5323-89d2-49d0-3fe56ba2ec3a@uwaterloo.ca>
Date:   Tue, 12 Oct 2021 12:25:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAFTs51W6ZHrGaoXEbXNCkVKLxe7_S2raYcXMBzypC7VUDMrU-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.32.190.116]
X-ClientProxiedBy: connhm01.connect.uwaterloo.ca (172.16.137.65) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 > Hi Thierry,
 >
 > sorry for the delayed reply - I'm finally going through the
 > documentation patches in preparation for the upcoming next version
 > patchset mail-out.

No problem.

 > The documentation here outlines what sys_umcg_wait does, and it does
 > put the current task to sleep without context switching if next_tid is
 > zero. The question of whether this behavior is or is not appropriate
 > for a worker wishing to yield/park itself is at a "policy" level, if
 > you wish, and this "policy" level is described in "state transitions"
 > section later in the document. sys_umcg_wait() does not enforce this
 > "policy" directly, in order to make it simpler and easier to describe
 > and reason about.

Just to be clear, sys_umcg_wait supports an operation that, when called 
from
a worker, puts the worker to sleep without triggering block detection
or context-switching back to the server?



 >> With that said, I'm a little confused by the usage of "yields" in that
 >> example. I would expect workers yielding to behave like kernel threads
 >> calling sched_yield(), i.e., context switch to the server but also be
 >> immediately added to the idle_workers_ptr.
 >
 > I'm not a fan of arguing about how to name things. If the maintainers
 > ask me to rename wait/wake to park/unpark, I'll do that.

I understand the sentiment, and I'm perfectly happy with the use of 
wait/wake.
I was exclusively referring to this one use of "yield" in the 
documentation.
