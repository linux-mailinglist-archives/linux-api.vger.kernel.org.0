Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705DC311F3A
	for <lists+linux-api@lfdr.de>; Sat,  6 Feb 2021 18:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhBFR5s (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 6 Feb 2021 12:57:48 -0500
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:47152 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230251AbhBFR5r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 6 Feb 2021 12:57:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 225168384365;
        Sat,  6 Feb 2021 17:57:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:960:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2692:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:3890:4250:4321:4605:5007:6119:6691:6742:7652:7903:7974:10004:10400:10848:11026:11232:11473:11658:11783:11914:12043:12295:12296:12297:12438:12555:12683:12740:12895:13439:13894:14093:14097:14181:14659:14721:21080:21325:21451:21611:21627:21939:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:17,LUA_SUMMARY:none
X-HE-Tag: power55_5f041ec275ef
X-Filterd-Recvd-Size: 3908
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat,  6 Feb 2021 17:57:01 +0000 (UTC)
Message-ID: <49124db60cdc88c4e9fcca1bbc9767432ad5a93b.camel@perches.com>
Subject: Re: [PATCH] printk: Userspace format enumeration support
From:   Joe Perches <joe@perches.com>
To:     Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Date:   Sat, 06 Feb 2021 09:57:00 -0800
In-Reply-To: <YB3Fwh827m0F+y3n@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name> <YB11jybvFCb95S9e@alley>
         <YB3Fwh827m0F+y3n@chrisdown.name>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 2021-02-05 at 22:25 +0000, Chris Down wrote:
> Petr Mladek writes:
> >   + <module> is already optinaly added by pr_fmt() to the printed strings
> >     as:  pr_fmt(): ...
> 
> pr_fmts are not consistently used across the kernel, and sometimes differ from 
> the module itself. Many modules don't use it at all, and we also don't have it 
> for pr_cont. Just picking some random examples:
> 
>      % grep -av vmlinux /proc/printk_formats | shuf -n 10
>      mac80211,6%s: mesh STA %pM switches to channel requiring DFS (%d MHz, width:%d, CF1/2: %d/%d MHz), aborting
>      thinkpad_acpi,c N/Athinkpad_acpi,c %dthinkpad_acpi,5thinkpad_acpi: temperatures (Celsius):thinkpad_acpi,3thinkpad_acpi: Out of memory for LED data

I don't understand this format.

"Out of memory for LED data" is a single printk ending with a '\n' newline 
I expected this to be broken up into multiple lines, one for each printk
that endsd in a newline.

And what would happen if the function was refactored removing the pr_cont
uses like the below: (basically, any output that uses a mechanism that
aggregates a buffer then emits it, and there are a _lot_ of those)

	printk("%s\n", buffer);

And there is already a relatively trivial way to do this using a modified
version of strings that looks for KERN_SOH[0-6], and if dynamic_debug is
enabled, look in the dynamic_debug section, either __verbose or __dyndbg
depending on the kernel version.

---
 drivers/platform/x86/thinkpad_acpi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 18b390153e7f..ff1c09c600f8 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6353,21 +6353,26 @@ static void thermal_dump_all_sensors(void)
 {
 	int n, i;
 	struct ibm_thermal_sensors_struct t;
+	char output[256];
+	int len = 0;
 
 	n = thermal_get_sensors(&t);
 	if (n <= 0)
 		return;
 
-	pr_notice("temperatures (Celsius):");
+	len += scnprintf(output + len, sizeof(output) - len,
+		       "temperatures (Celsius):");
 
 	for (i = 0; i < n; i++) {
-		if (t.temp[i] != TPACPI_THERMAL_SENSOR_NA)
-			pr_cont(" %d", (int)(t.temp[i] / 1000));
+		if (t.temp[i] == TPACPI_THERMAL_SENSOR_NA)
+			len += scnprintf(output + len, sizeof(output) - len,
+					 " N/A");
 		else
-			pr_cont(" N/A");
+			len += scnprintf(output + len, sizeof(output) - len,
+					 " %d", t.temp[i] / 1000);
 	}
 
-	pr_cont("\n");
+	pr_notice("%s\n", output);
 }
 
 /* sysfs temp##_input -------------------------------------------------- */

