Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09541A7953
	for <lists+linux-api@lfdr.de>; Tue, 14 Apr 2020 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgDNLZM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Apr 2020 07:25:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:44198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438988AbgDNLZL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 14 Apr 2020 07:25:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 053E6AC61;
        Tue, 14 Apr 2020 11:25:07 +0000 (UTC)
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters from
 kernel command line
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Iurii Zaikin <yzaikin@google.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <287ac6ae-a898-3e68-c7d8-4c1d17a40db9@suse.cz>
 <20200402160442.GA11244@42.do-not-panic.com> <202004021017.3A23B759@keescook>
 <20200402205932.GM11244@42.do-not-panic.com>
 <202004031654.C4389A04EF@keescook>
 <20200406140836.GA11244@42.do-not-panic.com>
 <202004060856.6BC17C5C99@keescook>
 <20200406170822.GE11244@42.do-not-panic.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7585f0b0-c5d2-b527-aac7-eeafdd15ffad@suse.cz>
Date:   Tue, 14 Apr 2020 13:25:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406170822.GE11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/6/20 7:08 PM, Luis Chamberlain wrote:
> On Mon, Apr 06, 2020 at 08:58:50AM -0700, Kees Cook wrote:
>> On Mon, Apr 06, 2020 at 02:08:36PM +0000, Luis Chamberlain wrote:
>> > > Yes. Doing an internal extension isn't testing the actual code.
>> > 
>> > But it would.
>> > 
>> > [...]
>> > > I don't think anything is needed for this series. It can be boot tested
>> > > manually.
>> > 
>> > Why test it manually when it could be tested automatically with a new kconfig?
>> 
>> So, my impression is that adding code to the internals to test the
>> internals isn't a valid test (or at least makes it fragile) because the
>> test would depend on the changes to the internals (or at least depend on
>> non-default non-production CONFIGs).
> 
> The *internal* aspect here is an extension to boot params under a
> kconfig which would simply append to it, as if the user would have

So there's no such kconfig yet to apply boot parameters specified by configure,
right? That would itself be a new feature. Or could we use bootconfig? (CC Masami)

> added some more params. Since we already have test sysctl params the
> only one we'd need to add on the test driver would be a dummy one which
> tests the alias, on the second patch. We should have enough sysctls to
> already test dummy values.

Right.

> Nothing else would be needed as the sysctl test driver would just need
> to test that the values expected when this is enabled is set.
> 
>> Can you send a patch for what you think this should look like? Perhaps
>> I'm not correctly imagining what you're describing?
> 
> I rather get the person involved in the changes to do the testing so
> as they're the ones designing the feature. If however it is not clear
> what I mean I'm happy to elaborate.
> 
> Vlastimil do you get what I mean?

Hopefully :)

>> Regardless of testing, I think this series is ready for -mm.
> 
> I'm happy for it to go in provided we at least devise a follow up plan
> for testing. Otherwise -- like other things, it won't get done.

OK I'll send a v2 and we can discuss the test driver details. I don't want to
neglect testing, but also not block the new functionality, in case it means
testing means adding another new functionality.

Thanks,
Vlastimil

>   Luis
> 

