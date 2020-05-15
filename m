Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDED1D5572
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2020 18:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgEOQCV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 May 2020 12:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgEOQCV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 15 May 2020 12:02:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37AFCABC2;
        Fri, 15 May 2020 16:02:21 +0000 (UTC)
Subject: Re: [PATCH v3 5/5] lib/test_sysctl: support testing of sysctl. boot
 parameter
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
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
References: <20200427180433.7029-1-vbabka@suse.cz>
 <20200427180433.7029-6-vbabka@suse.cz>
 <20200427183913.GH11244@42.do-not-panic.com>
 <028d1996-9f4c-20c6-fb2a-706baa919dde@suse.cz>
 <20200511183155.GT11244@42.do-not-panic.com>
 <d07e1dc9-cc2d-d471-2882-8ec563878fe7@suse.cz>
 <20200513131532.GO11244@42.do-not-panic.com>
 <CAB=NE6WGN=TiXE3PL3sAXa+5q9n8a83-vONMv1c1_HLMqnzPew@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <305af605-1e60-cf84-fada-6ce1ca37c102@suse.cz>
Date:   Fri, 15 May 2020 18:02:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAB=NE6WGN=TiXE3PL3sAXa+5q9n8a83-vONMv1c1_HLMqnzPew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/13/20 3:17 PM, Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 7:15 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>> > >
>> > > You want to:
>> > >
>> > >
>> > > # Kselftest framework requirement - SKIP code is 4.
>> > > ksft_skip=4
>> > >
>> > >>  sysctl_test_0007()
>> > >>  {
>> > >>    TARGET="${SYSCTL}/boot_int"
>> > >> +  if [ ! -f $TARGET ]; then
>> > >> +          echo "Skipping test for $TARGET as it is not present ..."
>> > >> +          return 0
>> > >> +  fi
>> > >
>> > > And return 4 instead.
>> >
>> > If I return it from the function, nobody will care, AFAICS. If I 'exit
>> > $ksft_skip', is that correct if it's just a single test out of 7?
>>
>> yes please do that.
> 
> Ah but once we add test_0008() it may be supported.. so I think return
> would be OK

OK

----8<----
From 4311b356f177aaa4e21bd3d2a2169e5bd50ab62d Mon Sep 17 00:00:00 2001
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
 tools/testing/selftests/sysctl/sysctl.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index ef6417b8067b..ab44d3e65986 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -756,10 +756,15 @@ sysctl_test_0006()
 sysctl_test_0007()
 {
 	TARGET="${SYSCTL}/boot_int"
+	if [ ! -f $TARGET ]; then
+		echo "Skipping test for $TARGET as it is not present ..."
+		return $ksft_skip
+	fi
+
 	if [ -d $DIR ]; then
 		echo "Boot param test only possible sysctl_test is built-in, not module:"
 		cat $TEST_DIR/config >&2
-		return 0
+		return $ksft_skip
 	fi
 
 	echo -n "Testing if $TARGET is set to 1 ..."
@@ -785,6 +790,7 @@ sysctl_test_0007()
 
 	echo "Skipping test, expected kernel parameter missing."
 	echo "To perform this test, make sure kernel is booted with parameter: sysctl.debug.test_sysctl.boot_int=1"
+	return $ksft_skip
 }
 
 list_tests()
-- 
2.26.2


