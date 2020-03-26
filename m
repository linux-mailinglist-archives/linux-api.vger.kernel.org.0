Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D26194B55
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 23:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCZWNM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 18:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:55580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCZWNL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 26 Mar 2020 18:13:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9B0E5ABBD;
        Thu, 26 Mar 2020 22:13:08 +0000 (UTC)
Subject: Re: [RFC v3 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
References: <20200326181606.7027-1-vbabka@suse.cz>
 <202003261256.950F1E5@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8afebb97-db51-5744-dca9-840dc60cd396@suse.cz>
Date:   Thu, 26 Mar 2020 23:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <202003261256.950F1E5@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/26/20 9:24 PM, Kees Cook wrote:
> On Thu, Mar 26, 2020 at 07:16:05PM +0100, Vlastimil Babka wrote:
>> Since the major change, I'm sending another RFC. If this approach is ok, then
>> it probably needs just some tweaks to the various error prints, and then
>> converting the rest of existing on-off aliases (if I come up with an idea how
>> to find them all). Thanks for all the feedback so far.
> 
> Yeah, I think you can drop "RFC" from this in the next version -- you're
> well into getting this finalized IMO.

Thanks!

>>
>>  .../admin-guide/kernel-parameters.txt         |  9 ++
>>  fs/proc/proc_sysctl.c                         | 90 +++++++++++++++++++
>>  include/linux/sysctl.h                        |  4 +
>>  init/main.c                                   |  2 +
>>  4 files changed, 105 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index c07815d230bc..0c7e032e7c2e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4793,6 +4793,15 @@
>>  
>>  	switches=	[HW,M68k]
>>  
>> +	sysctl.*=	[KNL]
>> +			Set a sysctl parameter, right before loading the init
>> +			process, as if the value was written to the respective
>> +			/proc/sys/... file. Unrecognized parameters and invalid
>> +			values are reported in the kernel log. Sysctls
>> +			registered later by a loaded module cannot be set this
>> +			way.
> 
> Maybe add: "Both '.' and '/' are recognized as separators."

OK

>> +
>> +/* Set sysctl value passed on kernel command line. */
>> +static int process_sysctl_arg(char *param, char *val,
>> +			       const char *unused, void *arg)
>> +{
>> +	char *path;
>> +	struct file_system_type *proc_fs_type;
>> +	struct file *file;
>> +	int len;
>> +	int err;
>> +	loff_t pos = 0;
>> +	ssize_t wret;
>> +
>> +	if (strncmp(param, "sysctl", sizeof("sysctl") - 1))
>> +		return 0;
>> +
>> +	param += sizeof("sysctl") - 1;
>> +
>> +	if (param[0] != '/' && param[0] != '.')
>> +		return 0;
>> +
>> +	param++;
>> +
>> +	if (!proc_mnt) {
>> +		proc_fs_type = get_fs_type("proc");
>> +		if (!proc_fs_type) {
>> +			pr_err("Failed to mount procfs to set sysctl from command line");
>> +			return 0;
>> +		}
>> +		proc_mnt = kern_mount(proc_fs_type);
>> +		put_filesystem(proc_fs_type);
>> +		if (IS_ERR(proc_mnt)) {
>> +			pr_err("Failed to mount procfs to set sysctl from command line");
>> +			proc_mnt = NULL;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	len = 4 + strlen(param) + 1;
>> +	path = kmalloc(len, GFP_KERNEL);
>> +	if (!path)
>> +		panic("%s: Failed to allocate %d bytes t\n", __func__, len);
>> +
>> +	strcpy(path, "sys/");
>> +	strcat(path, param);
>> +	strreplace(path, '.', '/');
> 
> You can do the replacement against the param directly, and also avoid
> all the open-coded string manipulations:
> 
> 	strreplace(param, '.', '/');

I didn't want to modify param for the sake of error prints, but perhaps
the replacements won't confuse system admin too much?

> 	path = kasprintf(GFP_KERNEL, "sys/%s", param);

Ah yea that's nicer.

>> +
>> +	file = file_open_root(proc_mnt->mnt_root, proc_mnt, path, O_WRONLY, 0);
>> +	if (IS_ERR(file)) {
>> +		err = PTR_ERR(file);
>> +		pr_err("Error %d opening proc file %s to set sysctl parameter '%s=%s'",
>> +			err, path, param, val);
>> +		goto out;
>> +	}
>> +	len = strlen(val);
>> +	wret = kernel_write(file, val, len, &pos);
>> +	if (wret < 0) {
>> +		err = wret;
>> +		pr_err("Error %d writing to proc file %s to set sysctl parameter '%s=%s'",
>> +			err, path, param, val);
>> +	} else if (wret != len) {
>> +		pr_err("Wrote only %ld bytes of %d  writing to proc file %s to set sysctl parameter '%s=%s'",
>> +			wret, len, path, param, val);
>> +	}
>> +
>> +	filp_close(file, NULL);
> 
> Please check the return value of filp_close() and treat that as an error
> for this function too.

Well I could print it, but not much else? The unmount will probably fail
in that case?

>> +out:
>> +	kfree(path);
>> +	return 0;
>> +}
>> +
>> +void do_sysctl_args(void)
>> +{
>> +	char *command_line;
>> +
>> +	command_line = kstrdup(saved_command_line, GFP_KERNEL);
>> +	if (!command_line)
>> +		panic("%s: Failed to allocate copy of command line\n", __func__);
>> +
>> +	parse_args("Setting sysctl args", command_line,
>> +		   NULL, 0, -1, -1, NULL, process_sysctl_arg);
>> +
>> +	if (proc_mnt)
>> +		kern_unmount(proc_mnt);
> 
> I don't recommend sharing allocation lifetimes between two functions
> (process_sysctl_arg() allocs proc_mnt, and do_sysctl_args() frees it).
> And since you have a scoped lifetime, why allocate it or have it as a
> global at all? It can be stack-allocated and passed to the handler:

So the point was that the mount is only done when an applicable sysctl
parameter is found. On majority of systems there won't be any, at least
for initial X years :)

> void do_sysctl_args(void)
> {
> 	struct file_system_type *proc_fs_type;
> 	struct vfsmount *proc_mnt;
> 	char *command_line;
> 
> 	proc_fs_type = get_fs_type("proc");
> 	if (!proc_fs_type) {
> 		pr_err("Failed to mount procfs to set sysctl from command line");
> 		return;
> 	}
> 	proc_mnt = kern_mount(proc_fs_type);
> 	put_filesystem(proc_fs_type);
> 	if (IS_ERR(proc_mnt)) {
> 		pr_err("Failed to mount procfs to set sysctl from command line");
> 		return;
> 	}
> 
> 	command_line = kstrdup(saved_command_line, GFP_KERNEL);
> 	if (!command_line)
> 		panic("%s: Failed to allocate copy of command line\n",
> 			__func__);
> 
> 	parse_args("Setting sysctl args", command_line,
> 		   NULL, 0, -1, -1, proc_mnt, process_sysctl_arg);
> 
> 	kfree(command_line);
> 	kern_unmount(proc_mnt);
> }
> 
> And then pull the mount from (the hilariously overloaded name) "arg":

But I guess the "mount on first applicable argument" approach would work
with this scheme as well:

struct vfsmount *proc_mnt = NULL;
parse_args(..., &proc_mnt, ...)

Thanks!
