Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF53A1CD725
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2020 13:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgEKLF1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 May 2020 07:05:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:36522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbgEKLF1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 11 May 2020 07:05:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4EB16AC64;
        Mon, 11 May 2020 11:05:27 +0000 (UTC)
Subject: Re: [PATCH v3 5/5] lib/test_sysctl: support testing of sysctl. boot
 parameter
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
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
References: <20200427180433.7029-1-vbabka@suse.cz>
 <20200427180433.7029-6-vbabka@suse.cz>
 <20200427183913.GH11244@42.do-not-panic.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <028d1996-9f4c-20c6-fb2a-706baa919dde@suse.cz>
Date:   Mon, 11 May 2020 13:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427183913.GH11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 4/27/20 8:39 PM, Luis Chamberlain wrote:
> On Mon, Apr 27, 2020 at 08:04:33PM +0200, Vlastimil Babka wrote:
> Nice, also we could just require
> 
> diff --git a/tools/testing/selftests/sysctl/config b/tools/testing/selftests/sysctl/config
> index 6ca14800d755..34461cc99a2b 100644
> --- a/tools/testing/selftests/sysctl/config
> +++ b/tools/testing/selftests/sysctl/config
> @@ -1 +1,3 @@
>  CONFIG_TEST_SYSCTL=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> 
> tools/testing/selftests/firmware/fw_lib.sh then has a kconfig_has()
> which can verify the exact config.

Hmm but it also has a (firmware area specific) fallback for case where
IKCONFIG_PROC doesn't exist. So it's simpler to just keep checking the module
dir, IMHO, as that would be the fallback. 

>> +
>> +	echo -n "Testing if $TARGET is set to 1 ..."
>> +	ORIG=$(cat "${TARGET}")
> 
> This would fail if someone uses this script to test an older kernel, and
> the scripts in selftests are supposed to work with older kernels.

Oh, I didn't know that it's supposed to.

> One
> way to address this would be to just see if the file exists first and
> ignore the test if the $SYSCTL directory exists but the file $TARGET
> does not.
> 
> For now we can just do this:
> 
> if [ ! -d $TARGET ]; then
> 	echo "Skipping test for $TARGET as it is not present ..."
> 	return 0
> fi

OK, just the -d test needs to be fixed :) Andrew can you please apply:

----8<----
From a999e993a89e521b152bbd4b1466f69e62879c30 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 11 May 2020 12:59:49 +0200
Subject: [PATCH] lib/test_sysctl: support testing of sysctl. boot parameter -
 fix

Skip the new test if boot_int sysctl is not present, otherwise, per Luis,
"This would fail if someone uses this script to test an older kernel, and
the scripts in selftests are supposed to work with older kernels."

Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/selftests/sysctl/sysctl.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index ef6417b8067b..148704f465b5 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -756,6 +756,11 @@ sysctl_test_0006()
 sysctl_test_0007()
 {
 	TARGET="${SYSCTL}/boot_int"
+	if [ ! -f $TARGET ]; then
+		echo "Skipping test for $TARGET as it is not present ..."
+		return 0
+	fi
+
 	if [ -d $DIR ]; then
 		echo "Boot param test only possible sysctl_test is built-in, not module:"
 		cat $TEST_DIR/config >&2
-- 
2.26.2

