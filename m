Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D4A1FB49B
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 16:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgFPOk1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 10:40:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:22009 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgFPOk1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 16 Jun 2020 10:40:27 -0400
IronPort-SDR: DN6jn5jKeblUYcoyTfTUi6pBgSxdvFtp3lPWwv7xpnPQVwBZ1TrdH+YO6KLTfEtQxkK8BvxU93
 CCmhJI6fI/0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 07:40:21 -0700
IronPort-SDR: qRAAkVPgstsP4BiNwiJ4ZWhpOs0JhFEgky588U/lbruil5tOAuN+ZQw758XauRakiPDe+wl0vn
 2O84ffZConlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="276937447"
Received: from osowole-mobl.amr.corp.intel.com (HELO [10.255.5.242]) ([10.255.5.242])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2020 07:40:17 -0700
Subject: Re: [PATCH 4/8] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-5-keescook@chromium.org>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzShEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gPGRhdmVAc3I3MS5uZXQ+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCTo3k0QIZAQAKCRBoNZUwcMmSsMO2D/421Xg8pimb9mPzM5N7khT0
 2MCnaGssU1T59YPE25kYdx2HntwdO0JA27Wn9xx5zYijOe6B21ufrvsyv42auCO85+oFJWfE
 K2R/IpLle09GDx5tcEmMAHX6KSxpHmGuJmUPibHVbfep2aCh9lKaDqQR07gXXWK5/yU1Dx0r
 VVFRaHTasp9fZ9AmY4K9/BSA3VkQ8v3OrxNty3OdsrmTTzO91YszpdbjjEFZK53zXy6tUD2d
 e1i0kBBS6NLAAsqEtneplz88T/v7MpLmpY30N9gQU3QyRC50jJ7LU9RazMjUQY1WohVsR56d
 ORqFxS8ChhyJs7BI34vQusYHDTp6PnZHUppb9WIzjeWlC7Jc8lSBDlEWodmqQQgp5+6AfhTD
 kDv1a+W5+ncq+Uo63WHRiCPuyt4di4/0zo28RVcjtzlGBZtmz2EIC3vUfmoZbO/Gn6EKbYAn
 rzz3iU/JWV8DwQ+sZSGu0HmvYMt6t5SmqWQo/hyHtA7uF5Wxtu1lCgolSQw4t49ZuOyOnQi5
 f8R3nE7lpVCSF1TT+h8kMvFPv3VG7KunyjHr3sEptYxQs4VRxqeirSuyBv1TyxT+LdTm6j4a
 mulOWf+YtFRAgIYyyN5YOepDEBv4LUM8Tz98lZiNMlFyRMNrsLV6Pv6SxhrMxbT6TNVS5D+6
 UorTLotDZKp5+M7BTQRUY85qARAAsgMW71BIXRgxjYNCYQ3Xs8k3TfAvQRbHccky50h99TUY
 sqdULbsb3KhmY29raw1bgmyM0a4DGS1YKN7qazCDsdQlxIJp9t2YYdBKXVRzPCCsfWe1dK/q
 66UVhRPP8EGZ4CmFYuPTxqGY+dGRInxCeap/xzbKdvmPm01Iw3YFjAE4PQ4hTMr/H76KoDbD
 cq62U50oKC83ca/PRRh2QqEqACvIH4BR7jueAZSPEDnzwxvVgzyeuhwqHY05QRK/wsKuhq7s
 UuYtmN92Fasbxbw2tbVLZfoidklikvZAmotg0dwcFTjSRGEg0Gr3p/xBzJWNavFZZ95Rj7Et
 db0lCt0HDSY5q4GMR+SrFbH+jzUY/ZqfGdZCBqo0cdPPp58krVgtIGR+ja2Mkva6ah94/oQN
 lnCOw3udS+Eb/aRcM6detZr7XOngvxsWolBrhwTQFT9D2NH6ryAuvKd6yyAFt3/e7r+HHtkU
 kOy27D7IpjngqP+b4EumELI/NxPgIqT69PQmo9IZaI/oRaKorYnDaZrMXViqDrFdD37XELwQ
 gmLoSm2VfbOYY7fap/AhPOgOYOSqg3/Nxcapv71yoBzRRxOc4FxmZ65mn+q3rEM27yRztBW9
 AnCKIc66T2i92HqXCw6AgoBJRjBkI3QnEkPgohQkZdAb8o9WGVKpfmZKbYBo4pEAEQEAAcLB
 XwQYAQIACQUCVGPOagIbDAAKCRBoNZUwcMmSsJeCEACCh7P/aaOLKWQxcnw47p4phIVR6pVL
 e4IEdR7Jf7ZL00s3vKSNT+nRqdl1ugJx9Ymsp8kXKMk9GSfmZpuMQB9c6io1qZc6nW/3TtvK
 pNGz7KPPtaDzvKA4S5tfrWPnDr7n15AU5vsIZvgMjU42gkbemkjJwP0B1RkifIK60yQqAAlT
 YZ14P0dIPdIPIlfEPiAWcg5BtLQU4Wg3cNQdpWrCJ1E3m/RIlXy/2Y3YOVVohfSy+4kvvYU3
 lXUdPb04UPw4VWwjcVZPg7cgR7Izion61bGHqVqURgSALt2yvHl7cr68NYoFkzbNsGsye9ft
 M9ozM23JSgMkRylPSXTeh5JIK9pz2+etco3AfLCKtaRVysjvpysukmWMTrx8QnI5Nn5MOlJj
 1Ov4/50JY9pXzgIDVSrgy6LYSMc4vKZ3QfCY7ipLRORyalFDF3j5AGCMRENJjHPD6O7bl3Xo
 4DzMID+8eucbXxKiNEbs21IqBZbbKdY1GkcEGTE7AnkA3Y6YB7I/j9mQ3hCgm5muJuhM/2Fr
 OPsw5tV/LmQ5GXH0JQ/TZXWygyRFyyI2FqNTx4WHqUn3yFj8rwTAU1tluRUYyeLy0ayUlKBH
 ybj0N71vWO936MqP6haFERzuPAIpxj2ezwu0xb1GjTk4ynna6h5GjnKgdfOWoRtoWndMZxbA
 z5cecg==
Message-ID: <fc0c14cd-bcf0-c94c-6cba-d0ce1844e93c@intel.com>
Date:   Tue, 16 Jun 2020 07:40:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616074934.1600036-5-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/16/20 12:49 AM, Kees Cook wrote:
> +	/* Mark the second page as untouched (i.e. "old") */
> +	preempt_disable();
> +	set_pte_at(&init_mm, vaddr, ptep, pte_mkold(*(READ_ONCE(ptep))));
> +	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
> +	preempt_enable();

If you can, I'd wrap that nugget up in a helper.  I'd also suggest being
very explicit in a comment about what it is trying to do: ensure no TLB
entries exist so that a future access will always set the Accessed bit.

> +	/* Make sure the PTE agrees that it is untouched. */
> +	if (WARN_ON_ONCE(sd_touched(ptep)))
> +		return;
> +	/* Read a portion of struct seccomp_data from the second page. */
> +	check = sd->instruction_pointer;
> +	/* First, verify the contents are zero from vzalloc(). */
> +	if (WARN_ON_ONCE(check))
> +		return;
> +	/* Now make sure the ACCESSED bit has been set after the read. */
> +	if (!sd_touched(ptep)) {
> +		/*
> +		 * If autodetection fails, fall back to standard beahavior by
> +		 * clearing the entire "allow" bitmap.
> +		 */
> +		pr_warn_once("seccomp: cannot build automatic syscall filters\n");
> +		bitmap_zero(bitmaps->allow, NR_syscalls);
> +		return;
> +	}

I can't find any big holes with this.  It's the kind of code that makes
me nervous, but mostly because it's pretty different that anything else
we have in the kernel.

It's also clear to me here that you probably have a slightly different
expectation of what the PTE accessed flag means versus the hardware
guys.  What you are looking for it to mean is roughly: "a retired
instruction touched this page".

The hardware guys would probably say it's closer to "a TLB entry was
established for this page."  Remember that TLB entries can be
established speculatively or from things like prefetchers.  While I
don't know of anything microarchitectural today which would trip this
mechanism, it's entirely possible that something in the future might.
Accessing close to the page boundary is the exact kind of place folks
might want to optimize.

*But*, at least it would err in the direction of being conservative.  It
would say "somebody touched the page!" more often than it should, but
never _less_ often than it should.

One thing about the implementation (which is roughly):

	// Touch the data:
	check = sd->instruction_pointer;
	// Examine the PTE mapping that data:
	if (!sd_touched(ptep)) {
		// something
	}

There aren't any barriers in there, which could lead to the sd_touched()
check being ordered before the data touch.  I think a rmb() will
suffice.  You could even do it inside sd_touched().

Was there a reason you chose to export a ranged TLB flush?  I probably
would have just used the single-page flush_tlb_one_kernel() for this
purpose if I were working in arch-specific code.
